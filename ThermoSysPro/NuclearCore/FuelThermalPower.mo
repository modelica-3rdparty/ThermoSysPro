within ThermoSysPro.NuclearCore;
model FuelThermalPower "Meshed model that describes the dynamic of the conduction of heat generated 
  by fission in a fuel rod."

  FuelProperties fuel[Nz,Nr](
    T=T,
    each porosity=fuel_porosity,
    each MOX=isMOX,
    each pu_mFraction=pu_mFraction,
    each oxy_on_metal=oxy_on_metal) "Fuel Properties";

  parameter Real fuel_porosity=0.05 "Fuel porosity" annotation(Dialog(group="Fuel Properties"));
  parameter Real oxy_on_metal=2 "Oxyde on Metal Ratio" annotation(Dialog(group="Fuel Properties"));
  parameter ThermoSysPro.Units.SI.Density rho_uo2=10950 "Density of UO2" annotation(Dialog(group="Fuel Properties"));
  parameter Boolean isMOX=false "Whether fuel is MOX or not" annotation(Dialog(group="Fuel Properties"));
  parameter Real pu_mFraction=0 "PuO2 Mass Fraction" annotation(Dialog(group="Fuel Properties",enable=isMOX));
  parameter ThermoSysPro.Units.SI.Density rho_puo2=11500 "Density of PuO2" annotation(Dialog(group="Fuel Properties",enable=isMOX));
  parameter ThermoSysPro.Units.SI.Density rho=(1-fuel_porosity)*1/(pu_mFraction/rho_puo2+(1-pu_mFraction)/rho_uo2) "Density of MOX" annotation(Dialog(group="Fuel Properties",enable=false));

  parameter Integer Nrods=50952 "Number of fuel rods of UO2" annotation(Dialog(group="Geometry"));
  parameter ThermoSysPro.Units.SI.Radius Rp=0.004095 "Radius of the fuel pellet" annotation(Dialog(group="Geometry"));
  parameter ThermoSysPro.Units.SI.Radius Rclad=0.00418 "Internal radius of the cladding" annotation(Dialog(group="Geometry"));
  parameter Integer Nz=6 "Number of axial zones" annotation(Dialog(group="Geometry"));
  parameter Integer Nr=5 "Number of radial zones" annotation(Dialog(group="Geometry"));
  parameter ThermoSysPro.Units.SI.Length Length=4.270 "Active lenght of the fuel rods" annotation(Dialog(group="Geometry"));
  parameter ThermoSysPro.Units.SI.Radius rsi[Nr]={sqrt(i*Rp^2/Nr) for i in 1:Nr} "Radii of volume skins (constant volume)" annotation(Dialog(group="Geometry",enable=false));
  parameter ThermoSysPro.Units.SI.Radius rvi[Nr]={sqrt((i-0.5)*Rp^2/Nr) for i in 1:Nr} "Radii of volume centers (constant volume)" annotation(Dialog(group="Geometry",enable=false));

  parameter Real zWt[Nz]={sin((i-0.5)*Lseg*pi/Length)/Length for i in 1:Nz}
    "Axial distribution of the thermal power produced in the zone i of the fuel";
  parameter Boolean steady_state=true annotation(choices(checkBox=true));
  parameter ThermoSysPro.Units.SI.Temperature Tstart=973.15;

  parameter ThermoSysPro.Units.SI.CoefficientOfHeatTransfer  heat_coeff_gap=10000
    "Heat Tranfer Coefficient between the fuel rods and the internal wall of the cladding";

protected
  parameter Real zWt_norm[Nz]=zWt / sum(zWt) "Normalized axial distribution of the thermal power produced in the zone i of the fuel";
  parameter ThermoSysPro.Units.SI.Length Lseg=Length/Nz "Lenght of the axial zones";
  parameter ThermoSysPro.Units.SI.Volume Mnode=Nrods*rho*pi*Rp*Rp*Lseg/Nr
    "Mass of fuel in each node";
  parameter ThermoSysPro.Units.SI.Area Sseg_cladi=Nrods*2*pi*Rclad*Lseg
    "Internal surface of the cladding in each segment";
  constant Real pi=Modelica.Constants.pi "Pi";

public

   ThermoSysPro.Units.SI.Temperature T[Nz, Nr] "Temperature of the fuel";
   ThermoSysPro.Units.SI.Temperature Tcenter[Nz] "Temperature at the center of the fuel";
   ThermoSysPro.Units.SI.Temperature Tout[Nz] "Temperature of surface of the fuel";

    ThermoSysPro.Units.SI.Temperature Teff[Nz](start=fill(Tstart, Nz))
    "Effective temperature of the UO2 per zone, used for the calculation of the Doppler effect";
   ThermoSysPro.Units.SI.Temperature Teffg(start=Tstart)
    "Effective global temperature of the UO2, used for the calculation of the Doppler effect";
   ThermoSysPro.Units.SI.Temperature Tg[Nz](start=fill(Tstart, Nz))
    "Internal T of the cladding";

   //ThermoSysPro.Units.SI.Power W[Nz,Nr] "Power transmitted from the UO2 to the cladding in zone i";
  ThermoSysPro.Units.SI.Power Wt
    "Total thermal power produced by the UO2 fuel";
  ThermoSysPro.Units.SI.Power Wcond[Nz,Nr+1]
    "Thermal power exchanger between nodes by conduction";
  ThermoSysPro.Units.SI.LinearPowerDensity linW[Nz]=zWt_norm*Wt/Nrods "Linear Power Density";

  ThermoSysPro.Thermal.Connectors.ThermalPort C_clad[Nz] annotation (Placement(transformation(extent={{100,-12},{120,10}},
          rotation=0), iconTransformation(extent={{100,-12},{120,10}})));
  ThermoSysPro.InstrumentationAndControl.Connectors.InputReal Wt_fuel
    annotation (Placement(transformation(extent={{-120,
            -10},{-100,10}}, rotation=0), iconTransformation(extent={{-120,-10},
            {-100,10}})));
  ThermoSysPro.InstrumentationAndControl.Connectors.OutputReal Teff_fuel
    annotation (Placement(transformation(
        origin={0,110},
        extent={{-10,-10},{10,10}},
        rotation=90), iconTransformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={0,110})));

initial equation
  if steady_state then
    for i in 1:Nz loop
      for j in 1:Nr loop
        der(T[i, j]) = 0;
      end for;
    end for;
  else
    for i in 1:Nz loop
      for j in 1:Nr loop
        T[i, j] = Tstart;
      end for;
    end for;
  end if;

equation
  -Wcond[:,end] =C_clad.W;
  Tg =C_clad.T;
  Wt =Wt_fuel.signal;
  Teffg =Teff_fuel.signal;

  Wcond[:,1] = zeros(Nz);  //Null thermal conduction power in the center
  Wcond[:,end] = heat_coeff_gap*Sseg_cladi*(Tout - Tg); //Convection power to the clad


  // Extrapolation of limit point (change in conductivities could be taken into account)
  Tcenter = T[:,1]*1.5 - T[:,2]*0.5;
  Tout = T[:,end]*1.5 - T[:,Nr-1]*0.5;

  for i in 1:Nz loop //Iterate on axial nodes
    for j in 1:Nr loop //Iterate on radial nodes

      //*** Energy balance in the fuel rods ***
      Mnode*fuel[i, j].cp*der(T[i, j]) = zWt_norm[i]*Wt/Nr + Wcond[i,j]-Wcond[i,j+1];

      if j<Nr then
        Wcond[i,j+1] = (fuel[i,j].k+fuel[i,j].k)/2 * (T[i,j]-T[i,j+1])/(rvi[j+1]-rvi[j]) * rsi[j]*pi*2*Lseg*Nrods;
      end if;

    end for;
  end for;

  // Calculation of the effective temperature in the zones (Rowlands correlation)
  Teff = 0.444*Tcenter + 0.556*Tout;
  // Mean effective temperature, weighted by thermal power
  Teffg = zWt_norm * Teff;

  annotation (Diagram(
      coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{100,100}}),
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
        "%name")}),
    Documentation(info="<html>
<p><b>Copyright &copy; EDF 2002 - 2024</b></p>
</HTML>
<html>
<p><b>ThermoSysPro Version 4.1</b></p>
</HTML>
"));
end FuelThermalPower;
