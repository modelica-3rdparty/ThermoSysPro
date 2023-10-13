within ThermoSysPro.NuclearCore;
model PuissResiduelle "Calcule la puissance résiduelle due à la désintégration des produits de fission du coeur
 du réacteur nucléaire; le module PRES peut traiter 6 groupes maximum de radio-isotopes"
  parameter Real Kris[:]={0.0251,0.01654,0.02586}
    "Fraction de puissance associée au groupe i";
  parameter Real Tris[:]={15,137,2910}
    "Constante de temps associée au groupe i (s)";
  parameter Boolean permanent=false;
protected
  parameter Integer N=size(Kris, 1) "Nombre de groupes de radio-isotopes";
public
  Units.SI.Power Pneut(start=3560e6) "Puissance neutronique totale(W)";
  Units.SI.Power PresTot "Puissance résiduelle totale (W)";
  Units.SI.Power Pres[N](start={89.35e6,58.88e6,92.05e6})
    "Puissances résiduelles associées aux groupes de radio-isotopes (W)";
  ThermoSysPro.InstrumentationAndControl.Connectors.InputReal EntreePneut
    annotation (Placement(transformation(extent={{-120,-10},{-100,10}},
          rotation=0)));
  ThermoSysPro.InstrumentationAndControl.Connectors.OutputReal SortiePresTot
    annotation (Placement(transformation(extent={{100,-10},{120,10}}, rotation=
            0)));
initial equation
  if permanent then
    for i in 1:N loop
      der(Pres[i]) = 0;
    end for;
  else
    Pres = {89.35e6,58.88e6,92.05e6};
  end if;
equation
  Pneut = EntreePneut.signal;
  PresTot = SortiePresTot.signal;
  PresTot = sum(Pres);
  for i in 1:N loop
    der(Pres[i]) = (Kris[i]*Pneut - Pres[i])/Tris[i];
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
          extent={{-78,90},{78,-96}},
          lineColor={0,0,0},
          fillPattern=FillPattern.VerticalCylinder,
          fillColor={255,128,0},
          textString=
               "%name"),
        Text(
          extent={{-132,28},{-132,16}},
          lineColor={0,0,0},
          fillPattern=FillPattern.VerticalCylinder,
          fillColor={255,128,0},
          textString=
               "Pneut"),
        Text(
          extent={{130,26},{130,14}},
          lineColor={0,0,0},
          fillPattern=FillPattern.VerticalCylinder,
          fillColor={255,128,0},
          textString=
               "Pres")}),Diagram(graphics={
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
          extent={{-76,74},{80,-74}},
          lineColor={0,0,0},
          fillPattern=FillPattern.VerticalCylinder,
          fillColor={255,128,0},
          textString=
               "PuissResiduelle"),
        Text(
          extent={{116,24},{116,12}},
          lineColor={0,0,0},
          fillPattern=FillPattern.VerticalCylinder,
          fillColor={255,128,0},
          textString=
               "Pres"),
        Text(
          extent={{-118,24},{-118,12}},
          lineColor={0,0,0},
          fillPattern=FillPattern.VerticalCylinder,
          fillColor={255,128,0},
          textString=
               "Pneut")}),
    Documentation(info="<html>
<p><b>Copyright &copy; EDF 2002 - 2010</b></p>
<p><b>ThermoSysPro Version 2.0</h4>
</HTML>
"));
end PuissResiduelle;
