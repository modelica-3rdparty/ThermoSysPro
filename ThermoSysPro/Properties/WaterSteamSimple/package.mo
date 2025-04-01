within ThermoSysPro.Properties;
package WaterSteamSimple "7 - Water/steam properties library (simple implementation)"
  extends ThermoSysPro.Properties.Common.ThermoSysProIcon;




annotation (
  Icon(coordinateSystem(
      preserveAspectRatio=false,
      extent={{-100,-100},{100,100}},
      grid={2,2},
      initialScale=0.1), graphics={Text(textString="")}),
  Window(
    x=0.05,
    y=0.26,
    width=0.25,
    height=0.25,
    library=1,
    autolayout=1),
  Documentation(info="<html>
<p><b>ThermoSysPro Version 4.1 </h4>
<p><span style=\"font-family: MS Shell Dlg 2;\">This library implements the thermodynamic properties for water and steam using simple polynomials.</span></h4>
</html>", revisions="<html>
<p><u><b>Authors</b></u></p>
<ul>
<li><span style=\"font-family: MS Shell Dlg 2;\">First implemented: March, 2017 by Sherpa Engineering for EDF.</span></li>
</ul>
</html>"));
end WaterSteamSimple;
