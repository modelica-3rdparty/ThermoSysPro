within ThermoSysPro.Neutronics;
model AntiReac "Calcule les contre-réactions neutroniques dues aux barres de contrôle, à l'effet Doppler, au
modérateur, au bore et au xénon pour un flux neutronique ponctuel (module KNEP)et pour des réactions de
type REP. La procédure d'arrêt d'urgence n'est pas prise en compte dans ce module."

  parameter Real adop=-2.5 "Coefficient Doppler (pcm/K)";
  parameter Units.SI.Temperature tdop=944 "Température Doppler associée(K)";
  parameter Units.SI.Temperature tmin=570.35 "Température H2O à 0%PN";
  parameter Units.SI.Temperature tmax=584.95
    "Température H2O moyenne coeur à 100%PN";
  parameter Real a1tmin=-23;
  parameter Real a2tmin=-12;
  parameter Real a1tmax=-40.3;
  parameter Real a2tmax=-20.6;
  parameter Real cb1=300;
  parameter Real cb2=695;
  parameter Real kxe=-1;
  parameter Real Cxenon0=0 "Concentration en xénon de référence (ppm)";
  parameter Units.SI.Temperature teffuo20=939.55
    "température effective de référence du combustible (K)";
  parameter Units.SI.Temperature tm0Coeur=584.31
    "température moyenne de référence du fluide modérateur (K)";

  parameter Real XPosgYEdiffg[25, 2]=[37, 5.3; 150, 5.3; 170, 9.7; 200, 12; 208,
      9.8; 229, 10.9; 237, 6.8; 277, 4.5; 315, 6.7; 355, 8.2; 389, 7.6; 400,
      4.7; 422, 2.2; 518, 3; 529, 4.5; 555, 4.3; 562, 5.3; 573, 2.6; 601, 1;
      714, 1.8; 744, 1.6; 775, 0; 775, 0; 775, 0; 775, 0]
    "XPosgYEdiffg (entrées = première colonne, sorties = deuxième colonne)";
  parameter Real XPosrYEdiffr[25, 2]=[0, 0.7; 37, 5; 50, 4.6; 65, 5.4; 84, 4.9;
      102, 5.5; 116, 4.9; 137, 5.7; 148, 4.8; 169, 5.7; 179, 4.9; 187, 5.6; 202,
      5.6; 210, 4.6; 217, 5.2; 224, 5; 233, 4; 259, 0; 260, 0; 260, 0; 260, 0;
      260, 0; 260, 0; 260, 0; 260, 0]
    "XPosrYEdiffr (entrées = première colonne, sorties = deuxième colonne)";

protected
  parameter Real cdop=-2*adop*sqrt(tdop);
  parameter Real XPosg[1, :]=transpose(matrix(XPosgYEdiffg[:, 1]))
    "Entrées de la table";
  parameter Real YEdiffg[1, :]=transpose(matrix(XPosgYEdiffg[:, 2]))
    "Sorties de la table";
  parameter Integer ng[1, 1]=[size(XPosg, 2)] "Taille de la table";
  Real vg[1, 1];
  parameter Real XPosr[1, :]=transpose(matrix(XPosrYEdiffr[:, 1]))
    "Entrées de la table";
  parameter Real YEdiffr[1, :]=transpose(matrix(XPosrYEdiffr[:, 2]))
    "Sorties de la table";
  parameter Integer nr[1, 1]=[size(XPosr, 2)] "Taille de la table";
  Real vr[1, 1];

public
  Real PosR "Position du groupe R (pas)";
  Real PosG "Position des groupes gris (pas)";
  Real Teffuo2 "Température effective du combustible (K)";
  Real TmCoeur "Température moyenne du fluide modérateur dans le coeur (K)";
  Real Cbore "Concentration en bore";
  Real Cxenon "Concentration en xénon";

  Real Reac "Réactivité totale (pcm)";
  Real ReacB "Réactivité fournie par les barres de contrôle (pcm)";
  Real ReacBG
    "Réactivité fournie par les barres de contrôle des groupes G (pcm)";
  Real ReacBR "Réactivité fournie par les barres de contrôle du groupe R (pcm)";
  Real ReacD
    "Réactivité fournie par l'effet Doppler (température combustible) (pcm)";
  Real ReacM "Réactivité fournie par l'effet modérateur (pcm)";
  Real ReacX "Réactivité fournie par le xénon (pcm)";
  Real R1;
  Real R2;
  Real Atmin;
  Real Atmax;
  Real Ckt;

  Real Ediffg "Efficacité différentielle des groupes gris";
  Real Ediffr "Efficacité différencielle du groupe R";

  ThermoSysPro.InstrumentationAndControl.Connectors.OutputReal SortieReacX
    annotation (Placement(transformation(extent={{100,-90},{120,-70}}, rotation=
           0)));
  ThermoSysPro.InstrumentationAndControl.Connectors.OutputReal SortieReacM
    annotation (Placement(transformation(extent={{100,-50},{120,-30}}, rotation=
           0)));
  ThermoSysPro.InstrumentationAndControl.Connectors.OutputReal SortieReacD
    annotation (Placement(transformation(extent={{100,-10},{120,10}}, rotation=
            0)));
  ThermoSysPro.InstrumentationAndControl.Connectors.OutputReal SortieReacB
    annotation (Placement(transformation(extent={{100,30},{120,50}}, rotation=0)));
  ThermoSysPro.InstrumentationAndControl.Connectors.OutputReal SortieReac
    annotation (Placement(transformation(extent={{100,70},{120,90}}, rotation=0)));
  ThermoSysPro.InstrumentationAndControl.Connectors.InputReal EntreeCbore
    annotation (Placement(transformation(extent={{-120,-70},{-100,-50}},
          rotation=0)));
  ThermoSysPro.InstrumentationAndControl.Connectors.InputReal EntreeTmCoeur
    annotation (Placement(transformation(extent={{-120,-30},{-100,-10}},
          rotation=0)));
  ThermoSysPro.InstrumentationAndControl.Connectors.InputReal EntreeTeffuo2
    annotation (Placement(transformation(extent={{-120,10},{-100,30}}, rotation=
           0)));
  ThermoSysPro.InstrumentationAndControl.Connectors.InputReal EntreePosG
    annotation (Placement(transformation(extent={{-120,50},{-100,70}}, rotation=
           0)));
  ThermoSysPro.InstrumentationAndControl.Connectors.InputReal EntreePosR
    annotation (Placement(transformation(extent={{-120,90},{-100,110}},
          rotation=0)));
  ThermoSysPro.InstrumentationAndControl.Connectors.InputReal EntreeCxenon
    annotation (Placement(transformation(extent={{-120,-110},{-100,-90}},
          rotation=0)));
initial equation
  ReacBG = 0;
  ReacBR = 0;

equation
  Reac = SortieReac.signal;
  ReacB = SortieReacB.signal;
  ReacD = SortieReacD.signal;
  ReacM = SortieReacM.signal;
  ReacX = SortieReacX.signal;

  PosR = EntreePosR.signal;
  PosG = EntreePosG.signal;
  Teffuo2 = EntreeTeffuo2.signal;
  TmCoeur = EntreeTmCoeur.signal;
  Cbore = EntreeCbore.signal;
  Cxenon = EntreeCxenon.signal;

  /* Réactivité fournie par les barres de contrôle*/
  ReacB = ReacBR + ReacBG;

  vg = [PosG];
  Ediffg = Interpolate(ng, XPosg, YEdiffg, vg);
  der(ReacBG) = Ediffg*der(PosG);

  vr = [PosR];
  Ediffr = Interpolate(nr, XPosr, YEdiffr, vr);
  der(ReacBR) = Ediffr*der(PosR);

  /* Réactivité fournie par l'effet Doppler (température combustible) */
  ReacD = cdop*(sqrt(teffuo20) - sqrt(Teffuo2));

  /* Réactivité fournie par l'effet modérateur */
  ReacM = R2 - R1;

  R1 = Atmax*(tmax - TmCoeur) + Ckt*(tmax - TmCoeur)^2*0.5;
  R2 = Atmax*(tmax - tm0Coeur) + Ckt*(tmax - tm0Coeur)^2*0.5;
  Atmin = a1tmin + (a2tmin - a1tmin)/(cb2 - cb1)*(Cbore - cb1);
  Atmax = a1tmax + (a2tmax - a1tmax)/(cb2 - cb1)*(Cbore - cb1);
  Ckt = (Atmin - Atmax)/(tmax - tmin);

  /* Réactivité fournie par le xénon*/
  ReacX = kxe*(Cxenon - Cxenon0);

  /* Réactivité Totale*/
  Reac = ReacB + ReacD + ReacM + ReacX;

  annotation (Icon(graphics={
        Text(
          extent={{-134,122},{-134,110}},
          lineColor={0,0,255},
          textString=
               "PosR"),
        Text(
          extent={{-136,-78},{-136,-90}},
          lineColor={0,0,255},
          textString=
               "Cxenon"),
        Text(
          extent={{-136,-38},{-136,-50}},
          lineColor={0,0,255},
          textString=
               "Cbore"),
        Text(
          extent={{-136,2},{-136,-10}},
          lineColor={0,0,255},
          textString=
               "TmCoeur"),
        Text(
          extent={{-136,42},{-136,30}},
          lineColor={0,0,255},
          textString=
               "Teffuo2"),
        Text(
          extent={{-136,82},{-136,70}},
          lineColor={0,0,255},
          textString=
               "PosG"),
        Text(
          extent={{136,102},{136,90}},
          lineColor={0,0,255},
          textString=
               "Reac"),
        Text(
          extent={{136,-60},{136,-72}},
          lineColor={0,0,255},
          textString=
               "ReacX"),
        Text(
          extent={{136,-20},{136,-32}},
          lineColor={0,0,255},
          textString=
               "ReacM"),
        Text(
          extent={{136,20},{136,8}},
          lineColor={0,0,255},
          textString=
               "ReacD"),
        Text(
          extent={{136,60},{136,48}},
          lineColor={0,0,255},
          textString=
               "ReacB"),
        Ellipse(
          extent={{-100,100},{100,-20}},
          lineColor={0,0,0},
          fillPattern=FillPattern.Sphere,
          fillColor={255,128,0}),
        Ellipse(
          extent={{-100,20},{100,-100}},
          lineColor={0,0,0},
          fillPattern=FillPattern.Sphere,
          fillColor={255,128,0}),
        Rectangle(
          extent={{-100,40},{100,-42}},
          lineColor={0,0,0},
          fillPattern=FillPattern.VerticalCylinder,
          fillColor={255,128,0}),
        Text(
          extent={{-82,102},{82,-98}},
          lineColor={0,0,255},
          textString=
               "%name")}),Diagram(graphics={
        Ellipse(
          extent={{-100,102},{100,-18}},
          lineColor={0,0,0},
          fillPattern=FillPattern.Sphere,
          fillColor={255,128,0}),
        Ellipse(
          extent={{-100,22},{100,-98}},
          lineColor={0,0,0},
          fillPattern=FillPattern.Sphere,
          fillColor={255,128,0}),
        Rectangle(
          extent={{-100,42},{100,-40}},
          lineColor={0,0,0},
          fillPattern=FillPattern.VerticalCylinder,
          fillColor={255,128,0}),
        Text(
          extent={{-76,104},{82,-96}},
          lineColor={0,0,255},
          textString=
               "AntiReac"),
        Text(
          extent={{-112,124},{-112,112}},
          lineColor={0,0,255},
          textString=
               "PosR"),
        Text(
          extent={{-114,84},{-114,72}},
          lineColor={0,0,255},
          textString=
               "PosG"),
        Text(
          extent={{-116,44},{-116,32}},
          lineColor={0,0,255},
          textString=
               "Teffuo2"),
        Text(
          extent={{-114,4},{-114,-8}},
          lineColor={0,0,255},
          textString=
               "TmCoeur"),
        Text(
          extent={{-114,-36},{-114,-48}},
          lineColor={0,0,255},
          textString=
               "Cbore"),
        Text(
          extent={{-114,-76},{-114,-88}},
          lineColor={0,0,255},
          textString=
               "Cxenon"),
        Text(
          extent={{116,104},{116,92}},
          lineColor={0,0,255},
          textString=
               "Reac"),
        Text(
          extent={{116,-58},{116,-70}},
          lineColor={0,0,255},
          textString=
               "ReacX"),
        Text(
          extent={{116,-18},{116,-30}},
          lineColor={0,0,255},
          textString=
               "ReacM"),
        Text(
          extent={{116,22},{116,10}},
          lineColor={0,0,255},
          textString=
               "ReacD"),
        Text(
          extent={{116,62},{116,50}},
          lineColor={0,0,255},
          textString=
               "ReacB")}),
    Documentation(info="<html>
<p><b>Copyright &copy; EDF 2002 - 2010</b></p>
<p><b>ThermoSysPro Version 2.0</h4>
</HTML>
"));
end AntiReac;
