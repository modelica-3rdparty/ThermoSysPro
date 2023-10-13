within ThermoSysPro.Neutronics;
model Uranium "Modèle maillé décrivant la dynamique de conduction de
 la chaleur de fission dans une barre de combustible nucléaire."

  parameter Integer Nbarre=50952 "Nombre de crayons d'UO2";
  parameter Units.SI.Length Ru=0.004095 "Rayon de la pastille d'UO2";
  parameter Units.SI.Length Rgi=0.00418 "Rayon interne de la gaine";
  parameter Integer N=6 "Nombre de zones";
  parameter Units.SI.Length L[N]={0.7112,0.7112,0.7112,0.7112,0.7112,0.7112}
    "Longueur des zones (Saisir un tableau de taille N)";
  parameter Real xWt[N]={0.0679,0.1829,0.2492,0.2492,0.1829,0.0679}
    "Fraction de la puissance thermique totale produite dans la zone i du combustible";
  parameter Boolean permanent=false;

protected
  parameter Units.SI.Density rho=10950 "Masse volumique du combustible UO2";
  parameter Units.SI.CoefficientOfHeatTransfer hug=10000
    "Coefficient d'échange thermique entre les crayons d'uranium et l'intérieur de la gaine";
  parameter Units.SI.Mass dM[N]=Nbarre*rho*pi*Ru*Ru*L
    "masse d'UO2 de la zone i";
  parameter Units.SI.Area dSgi[N]=Nbarre*2*pi*Rgi*L
    "Surface intérieure de la gaine pour la zone i";
  constant Real pi=Modelica.Constants.pi "Pi";
  parameter Units.SI.Temperature Tstart=900;
  Units.SI.Temperature Tm[N,2](start=fill(
        Tstart,
        N,
        2)) "Température moyenne entre 1 et 2, et entre 2 et 3";
  Units.SI.SpecificHeatCapacity cp[N,3] "Chaleur spécifique de l'UO2";
  Units.SI.ThermalConductivity k[N,2] "Conductivité thermique de l'UO2";
  Real Coef "Coefficient intérmédiaire";

public
  Units.SI.Temperature T[N,3](start=fill(
        Tstart,
        N,
        3)) "Température du combustible UO2";
  /* Température de l'UO2 pour chaque zone axiale i :
       T[i,1] : température au centre de l'UO2
       T[i,2] : température à R/(2^0.5)
       T[i,3] : température extérieure UO2
   Rq : R/(2^0.5) définit deux zones isovolumes  */
  Units.SI.Temperature Teff[N](start=fill(Tstart, N))
    "Température effective de l'UO2 par zone, destinée à calculer l'effet Doppler";
  Units.SI.Temperature Teffg(start=Tstart)
    "Température efféctive globale de l'UO2, destinée à calculer l'effet Doppler";
  Units.SI.Temperature Tg[N](start=fill(Tstart, N))
    "Température intérieur de la gaine";

  Units.SI.Power W[N] "Puissance fournie par l'UO2 à la gaine pour la zone i";
  Units.SI.Power Wt "Puissance thermique totale fournie par le combustible UO2";

  ThermoSysPro.Thermal.Connectors.ThermalPort C_WTgaine[N]
    annotation (Placement(transformation(extent={{100,-10},{120,12}}, rotation=
            0)));
  ThermoSysPro.InstrumentationAndControl.Connectors.InputReal EntreePt
    annotation (Placement(transformation(extent={{-120,-10},{-100,10}},
          rotation=0)));
  ThermoSysPro.InstrumentationAndControl.Connectors.OutputReal SortieTeffuo2
    annotation (Placement(transformation(
        origin={0,110},
        extent={{-10,-10},{10,10}},
        rotation=90)));

initial equation
  if permanent then
    for i in 1:N loop
      for j in 1:3 loop
        der(T[i, j]) = 0;
      end for;
    end for;
  end if;

equation
  -W = C_WTgaine.W;
  Tg = C_WTgaine.T;
  Wt = EntreePt.signal;
  Teffg = SortieTeffuo2.signal;

  Coef = 4/(Ru*Ru*rho);

  for i in 1:N loop

    //*** Bilan d'énergie dans les crayon d'UO2 ***
    cp[i, 1]*der(T[i, 1]) = xWt[i]*Wt/dM[i] + 2*Coef*k[i, 1]*(T[i, 2] - T[i, 1]);

    cp[i, 2]*der(T[i, 2]) = xWt[i]*Wt/dM[i] + Coef*(-k[i, 1]*(T[i, 2] - T[i, 1])
       + 3*k[i, 2]*(T[i, 3] - T[i, 2]));

    cp[i, 3]*der(T[i, 3]) = xWt[i]*Wt/dM[i] - 6*Coef*k[i, 2]*(T[i, 3] - T[i, 2])
       - 4*W[i]/dM[i];

    //*** Echange thermique entre les crayons et la gaine***
    W[i] = hug*dSgi[i]*(T[i, 3] - Tg[i]);

    // Calcul de la conductivité thermique de l'UO2
    for j in 1:2 loop
      Tm[i, j] = 0.5*(T[i, j] + T[i, j + 1]);
      k[i, j] = 1/(0.0322 + 0.0002497*Tm[i, j]) + 0.641576e-10*Tm[i, j]*Tm[i, j]
        *Tm[i, j];
    end for;

    // Calcul de la chaleur spécifique de l'UO2
    for j in 1:3 loop
      cp[i, j] = 4186.8/270*(18.45 + 0.002431*T[i, j] - 2.272e5/(T[i, j]*T[i, j]));
    end for;

    // Calcul de la température effective des zones
    Teff[i] = 0.444*T[i, 1] + 0.556*T[i, 3];

  end for;

  // Calcul de la température effective globale
  Teffg = 0.023*Teff[1] + 0.167*Teff[2] + 0.31*Teff[3] + 0.31*Teff[4] + 0.167*
    Teff[5] + 0.023*Teff[6];

  annotation (Diagram(graphics={
        Rectangle(
          extent={{-100,100},{100,-100}},
          lineColor={0,0,0},
          fillPattern=FillPattern.VerticalCylinder,
          fillColor={255,128,0}),
        Text(
          extent={{-72,96},{80,-96}},
          lineColor={0,0,0},
          fillPattern=FillPattern.VerticalCylinder,
          fillColor={255,128,0},
          textString=
               "Uranium"),
        Text(
          extent={{-114,28},{-114,12}},
          lineColor={0,0,255},
          textString=
               "Puo2"),
        Text(
          extent={{2,94},{2,78}},
          lineColor={0,0,255},
          textString=
               "Teffuo2")}),Icon(graphics={Rectangle(
          extent={{-100,100},{100,-100}},
          lineColor={0,0,0},
          fillPattern=FillPattern.VerticalCylinder,
          fillColor={255,128,0}), Text(
          extent={{-74,102},{82,-84}},
          lineColor={0,0,0},
          fillPattern=FillPattern.VerticalCylinder,
          fillColor={255,128,0},
          textString=
               "%name")}),
    Documentation(info="<html>
<p><b>Copyright &copy; EDF 2002 - 2010</b></p>
<p><b>ThermoSysPro Version 2.0</h4>
</HTML>
"));
end Uranium;
