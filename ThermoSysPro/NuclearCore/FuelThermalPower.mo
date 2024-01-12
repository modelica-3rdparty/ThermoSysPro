within ThermoSysPro.NuclearCore;
model FuelThermalPower "Grid model that describes the dynamic of the conduction of heat generated 
  by fission in a fuel rod."

  parameter Integer Nrods=50952 "Number of fuel rods of UO2";
  parameter ThermoSysPro.Units.SI.Length Rp=0.004095 "Radius of the fuel pellet";
  parameter ThermoSysPro.Units.SI.Length Rclad=0.00418 "Internal radius of the cladding";
  parameter Integer N=6 "Number of zones";
  parameter ThermoSysPro.Units.SI.Length Length=2 "Active lenght of the fuel rods";
  parameter ThermoSysPro.Units.SI.Length L[N]={Length/N,Length/N,Length/N,Length/N,Length/N,
      Length/N} "Lenght of the zones (insert a table of size N)";
  parameter Real xWt[N]={0.0679,0.1829,0.2492,0.2492,0.1829,0.0679}
    "Fraction of the total thermal power produced in the zone i of the fuel";
  parameter Boolean steady_state=false;
  parameter ThermoSysPro.Units.SI.Temperature Tstart=973.15;

protected
  parameter ThermoSysPro.Units.SI.Density rho=10950
    "Density of the UO2 fuel";
  parameter ThermoSysPro.Units.SI.CoefficientOfHeatTransfer  heat_coeff_clad=10000
    "Heat Tranfer Coefficient between the fuel rods and the internal wall of the cladding";
  parameter ThermoSysPro.Units.SI.Mass dM[N]=Nrods*rho*pi*Rp*Rclad*L
    "Mass of fuel in the zone i";
  parameter ThermoSysPro.Units.SI.Area dSgi[N]=Nrods*2*pi*Rclad*L
    "Internal surface of the cladding in zone i";
  constant Real pi=Modelica.Constants.pi "Pi";
 // parameter ThermoSysPro.Units.SI.Temperature Tstart(start=973.15, fixed=true);
  //ThermoSysPro.Units.SI.Temperature Tm[N, 2](start=fill(Tstart, N, 2))
 ThermoSysPro.Units.SI.Temperature Tm[N, 2]
    "Average T between 1 and 2, and between 2 and 3";
  ThermoSysPro.Units.SI.SpecificHeatCapacity cp[N, 3] "Specific heat of UO2";
  ThermoSysPro.Units.SI.ThermalConductivity k[N, 2]  "Thermal conductivity of UO2";
  Real Coef "Intermediate coefficient";

  // ThermoSysPro.Units.SI.Temperature T[N, 3](start=fill(Tstart, N, 3))
public
   ThermoSysPro.Units.SI.Temperature T[N, 3]
    "Temperature of the fuel";
  /* Temperature of the fuel in each axial zone i *:
  T[i,1] : temperature at the centre of the pellet
       T[i,2] : temperature qt R/(2^0.5)
       T[i,3] : temperature at the external surface of the pellet
   Rq : R/(2^0.5) définit deux zones isovolumes ? */
   ThermoSysPro.Units.SI.Temperature Teff[N](start=fill(Tstart, N))
    "Effective temperature of the UO2 per zone, used for the calculation of the Doppler effect";
   ThermoSysPro.Units.SI.Temperature Teffg(start=Tstart)
    "Effective global temperature of the UO2, used for the calculation of the Doppler effect";
   ThermoSysPro.Units.SI.Temperature Tg[N](start=fill(Tstart, N))
    "Internal T of the cladding";

  ThermoSysPro.Units.SI.Power W[N]
    "Power transmitted from the UO2 to the cladding in zone i";
  ThermoSysPro.Units.SI.Power Wt
    "Total thermal power produced by the UO2 fuel";

  ThermoSysPro.Thermal.Connectors.ThermalPort C_WTgaine[N]
    annotation (extent=[100, -10; 120, 12], Placement(transformation(extent={{
            100,-10},{120,12}}, rotation=0)));
  ThermoSysPro.InstrumentationAndControl.Connectors.InputReal EntreePt
    annotation (extent=[-120, -10; -100, 10], Placement(transformation(extent={
            {-120,-10},{-100,10}}, rotation=0)));
  ThermoSysPro.InstrumentationAndControl.Connectors.OutputReal SortieT_fuel
    annotation (extent=[-10, 100; 10, 120], rotation=90,
    Placement(transformation(
        origin={0,110},
        extent={{-10,-10},{10,10}},
        rotation=90)));

initial equation
  if steady_state then
    for i in 1:N loop
      for j in 1:3 loop
        der(T[i, j]) = 0;
      end for;
    end for;
  else
    for i in 1:N loop
      for j in 1:3 loop
        T[i, j] = 973.15;
      end for;
    end for;
  end if;

equation
  -W = C_WTgaine.W;
  Tg = C_WTgaine.T;
  Wt = EntreePt.signal;
  Teffg = SortieT_fuel.signal;

  Coef = 4/(Rp*Rp*rho);

  for i in 1:N loop

    //*** Energy balance in the fuel rods ***
    cp[i, 1]*der(T[i, 1]) = xWt[i]*Wt/dM[i] + 2*Coef*k[i, 1]*(T[i, 2] - T[i, 1]);

    cp[i, 2]*der(T[i, 2]) = xWt[i]*Wt/dM[i] + Coef*(-k[i, 1]*(T[i, 2] - T[i, 1])
       + 3*k[i, 2]*(T[i, 3] - T[i, 2]));

    cp[i, 3]*der(T[i, 3]) = xWt[i]*Wt/dM[i] - 6*Coef*k[i, 2]*(T[i, 3] - T[i, 2])
       - 4*W[i]/dM[i];

    //***Thermal exchange between the fuel rod and the cladding***
    W[i] = heat_coeff_clad*dSgi[i]*(T[i, 3] - Tg[i]);

    // Calculation of the thermal conductivity of the UO2
    for j in 1:2 loop
      Tm[i, j] = 0.5*(T[i, j] + T[i, j + 1]);
      k[i, j] = 1/(0.0322 + 0.0002497*Tm[i, j]) + 0.641576e-10*Tm[i, j]*Tm[i, j]
        *Tm[i, j];
    end for;

    // Calculation of the specific heat of the UO2
    for j in 1:3 loop
      cp[i, j] = 4186.8/270*(18.45 + 0.002431*T[i, j] - 2.272e5/(T[i, j]*T[i, j]));
    end for;

    // Calculation of the effective temperature in the zones (Rowlands correlation)
    Teff[i] = 0.444*T[i, 1] + 0.556*T[i, 3];

  end for;

  // Calculation of the global effective temperature
  Teffg = 0.023*Teff[1] + 0.167*Teff[2] + 0.31*Teff[3] + 0.31*Teff[4] + 0.167*
    Teff[5] + 0.023*Teff[6];

  annotation (Diagram(
      coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{100,100}}),
      Rectangle(extent=[-100, 100; 100, -100], style(
          color=3,
          rgbcolor={0,0,255},
          gradient=1,
          fillColor=45,
          rgbfillColor={255,128,0})),
      Text(
        extent=[-72, 96; 80, -96],
        style(
          color=3,
          rgbcolor={0,0,255},
          gradient=1,
          fillColor=45,
          rgbfillColor={255,128,0}),
        string="Uranium"),
      Text(
        extent=[-114, 28; -114, 12],
        style(color=3, rgbcolor={0,0,255}),
        string="Puo2"),
      Text(
        extent=[2, 94; 2, 78],
        style(color=3, rgbcolor={0,0,255}),
        string="T_fuel"),
      graphics={
        Rectangle(
          extent={{-100,100},{100,-100}},
          lineColor={0,0,0},
          fillPattern=FillPattern.VerticalCylinder,
          fillColor={255,128,0}),
        Text(
          extent={{-72,96},{80,-96}},
          textColor={0,0,0},
          textString=
               "Uranium"),
        Text(
          extent={{-114,28},{-114,12}},
          textColor={0,0,255},
          textString=
               "Puo2"),
        Text(
          extent={{2,94},{2,78}},
          textColor={0,0,255},
          textString=
               "T_fuel")}),Icon(
      graphics={Rectangle(
          extent={{-100,100},{100,-100}},
          lineColor={0,0,0},
          fillPattern=FillPattern.VerticalCylinder,
          fillColor={255,128,0}), Text(
          extent={{-74,102},{82,-84}},
          textColor={0,0,0},
          textString=
               "%name")},        Rectangle(extent=[-100, 100; 100, -100], style(
          color=3,
          rgbcolor={0,0,255},
          gradient=1,
          fillColor=45,
          rgbfillColor={255,128,0})), Text(
        extent=[-74, 102; 82, -84],
        style(
          color=3,
          rgbcolor={0,0,255},
          gradient=1,
          fillColor=45,
          rgbfillColor={255,128,0}),
        string="%name")),
    Documentation(info="<html>
<p><b>Copyright &copy; EDF 2002 - 2010</b></p>
</HTML>
<html>
<p><b>ThermoSysPro Version 2.0</b></p>
</HTML>
"));
end FuelThermalPower;
