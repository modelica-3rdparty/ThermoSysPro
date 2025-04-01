within ThermoSysPro.Properties;
package Fluid "Generic fluid properties library"
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
<p><b>ThermoSysPro Version 4.1</b> </p>
<p>This library is an interface for the following fluid properties libraries:</p>
<ol>
<li>Water and steam (industrial IAPWS-IF97 standard)</li>
<li>C3HF5</li>
<li>Flue gases</li>
<li>Molten salt</li>
<li>Oil</li>
<li>Dry air (ideal gas)</li>
<li>Water and steam (simple implementation) </li>
</ol>
</html>"));
end Fluid;
