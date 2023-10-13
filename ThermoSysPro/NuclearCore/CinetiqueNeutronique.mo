within ThermoSysPro.NuclearCore;
model CinetiqueNeutronique "Ce module représente un modèle de flux neutronique ponctuel à six groupes de neutrons retardés.
A partir de la réactivité totale, entrée du module et somme de tous les effets possibles (Doppler,
modérateur, grappes, bore et xénon), il calcule la puissance de fission du réacteur. La puissance
totale est la somme de la puissance neutronique et de la puissance résiduelle (entrée du module)."
  parameter Units.SI.Time Tvie=23.27e-6
    "Durée de vie moyenne des neutrons prompts (s)";
  parameter Real Kuo2=1
    "Rapport entre la puissance développée dans le combustible et la puissance totale";
  parameter Real Lambda[6]={0.0125,0.0308,0.1143,0.3103,1.2331,3.289}
    "Constantes radioactives des groupes de neutrons retardés (1/s)";
  parameter Real Beta[6]={0.00021,0.00142,0.00131,0.00274,0.000932,0.000313}
    "Nombre de neutrons retardés pour chacun des groupes rapportéau nombre total de neutrons émis par fission";
  parameter Boolean permanent=false;
  parameter Real Puo20=3800e6 "Puissance d'initialisation (à 100% ?) du coeur";
protected
  Real SumBeta=sum(Beta);
public
  Units.SI.Power Pneut(start=3800e6) "Puissance neutronique (W)";
  Units.SI.Power Pnret[6](start={2570e9,7052.7e9,1753.3e9,1350.8e9,115.62e9,
        14.558e9})
    "Puissance associée aux 6 groupes de neutrons retardés (W)";
  Units.SI.Power Ptot "Puissance totale du réacteur (W)";
  Units.SI.Power Puo2 "Puissance développée dans le combustible (W)";
  Units.SI.Power Ph2o "Puissance directement reçue par le modérateur (W)";
  Real Reac "Réactivité totale (pcm)";
  Units.SI.Power Pres "Puissance résiduelle (W)";
  ThermoSysPro.InstrumentationAndControl.Connectors.InputReal EntreeReac
    annotation (Placement(transformation(extent={{-120,30},{-100,50}}, rotation=
           0)));
  ThermoSysPro.InstrumentationAndControl.Connectors.InputReal EntreePres
    annotation (Placement(transformation(extent={{-120,-50},{-100,-30}},
          rotation=0)));
  ThermoSysPro.InstrumentationAndControl.Connectors.OutputReal SortiePneut
    annotation (Placement(transformation(extent={{100,40},{120,60}}, rotation=0)));
  ThermoSysPro.InstrumentationAndControl.Connectors.OutputReal SortiePtot
    annotation (Placement(transformation(extent={{100,6},{120,26}}, rotation=0)));
  ThermoSysPro.InstrumentationAndControl.Connectors.OutputReal SortiePuo2
    annotation (Placement(transformation(extent={{100,-26},{120,-6}}, rotation=
            0)));
  ThermoSysPro.InstrumentationAndControl.Connectors.OutputReal SortiePh2o
    annotation (Placement(transformation(extent={{100,-60},{120,-40}}, rotation=
           0)));
initial equation
  if permanent then
    // 05-2005 N.Desvignes
    // der(Pneut) = 0;
    Puo2 = Puo20;
    for i in 1:6 loop
      der(Pnret[i]) = 0;
    end for;
  else
    Pneut = 3800e6;
    Pnret = {2570e9,7052.7e9,1753.3e9,1350.8e9,115.62e9,14.558e9};
  end if;
equation
  Reac = EntreeReac.signal;
  Pres = EntreePres.signal;
  Pneut = SortiePneut.signal;
  Ptot = SortiePtot.signal;
  Puo2 = SortiePuo2.signal;
  Ph2o = SortiePh2o.signal;
  Ptot - (Pneut + Pres) = 0;
  Puo2 - Kuo2*Ptot = 0;
  Ph2o - (1 - Kuo2)*Ptot = 0;
  // 05-2005 N.Desvignes
  // der(Pneut) = (Reac - SumBeta)*Pneut/Tvie + sum(Lambda .* Pnret);
  der(Pneut) = (Reac*1e-5 - SumBeta)*Pneut/Tvie + sum(Lambda .* Pnret);
  for i in 1:6 loop
    der(Pnret[i]) = Beta[i]*Pneut/Tvie - Lambda[i]*Pnret[i];
  end for;
  annotation (Icon(graphics={
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
          extent={{-78,92},{78,-84}},
          lineColor={0,0,0},
          fillPattern=FillPattern.VerticalCylinder,
          fillColor={255,128,0},
          textString=
               "%name"),
        Text(
          extent={{-130,68},{-130,56}},
          lineColor={0,0,0},
          fillPattern=FillPattern.VerticalCylinder,
          fillColor={255,128,0},
          textString=
               "Reac"),
        Text(
          extent={{-134,-14},{-134,-26}},
          lineColor={0,0,0},
          fillPattern=FillPattern.VerticalCylinder,
          fillColor={255,128,0},
          textString=
               "Pres"),
        Text(
          extent={{140,38},{140,26}},
          lineColor={0,0,0},
          fillPattern=FillPattern.VerticalCylinder,
          fillColor={255,128,0},
          textString=
               "Ptot"),
        Text(
          extent={{142,74},{142,62}},
          lineColor={0,0,0},
          fillPattern=FillPattern.VerticalCylinder,
          fillColor={255,128,0},
          textString=
               "Pneut"),
        Text(
          extent={{142,6},{142,-6}},
          lineColor={0,0,0},
          fillPattern=FillPattern.VerticalCylinder,
          fillColor={255,128,0},
          textString=
               "Puo2"),
        Text(
          extent={{142,-28},{142,-40}},
          lineColor={0,0,0},
          fillPattern=FillPattern.VerticalCylinder,
          fillColor={255,128,0},
          textString=
               "Ph2o")}),Diagram(graphics={
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
          extent={{-110,62},{-110,50}},
          lineColor={0,0,0},
          fillPattern=FillPattern.VerticalCylinder,
          fillColor={255,128,0},
          textString=
               "Reac"),
        Text(
          extent={{-110,-18},{-110,-30}},
          lineColor={0,0,0},
          fillPattern=FillPattern.VerticalCylinder,
          fillColor={255,128,0},
          textString=
               "Pres"),
        Text(
          extent={{-88,60},{92,-56}},
          lineColor={0,0,255},
          textString=
               "CinetiqueNeutronique"),
        Text(
          extent={{112,72},{112,60}},
          lineColor={0,0,0},
          fillPattern=FillPattern.VerticalCylinder,
          fillColor={255,128,0},
          textString=
               "Pneut"),
        Text(
          extent={{110,36},{110,24}},
          lineColor={0,0,0},
          fillPattern=FillPattern.VerticalCylinder,
          fillColor={255,128,0},
          textString=
               "Ptot"),
        Text(
          extent={{112,4},{112,-8}},
          lineColor={0,0,0},
          fillPattern=FillPattern.VerticalCylinder,
          fillColor={255,128,0},
          textString=
               "Puo2"),
        Text(
          extent={{112,-30},{112,-42}},
          lineColor={0,0,0},
          fillPattern=FillPattern.VerticalCylinder,
          fillColor={255,128,0},
          textString=
               "Ph2o")}),
    Documentation(info="<html>
<p><b>Copyright &copy; EDF 2002 - 2010</b></p>
<p><b>ThermoSysPro Version 2.0</h4>
</HTML>
"));
end CinetiqueNeutronique;
