within ThermoSysPro.Properties;
package DryAirIdealGas "6 - Dry air ideal gas properties library"
  extends ThermoSysPro.Properties.Common.ThermoSysProIcon;


annotation (
  Icon(coordinateSystem(
      preserveAspectRatio=false,
      extent={{-100,-100},{100,100}},
      grid={2,2},
      initialScale=0.1), graphics={Text(textString="")}),
  Window(
    x=0.45,
    y=0.01,
    width=0.44,
    height=0.65,
    library=1,
    autolayout=1),
  Documentation(revisions="<html>
<p><u><b>Authors</b></u></p>
<ul>
<li>Baligh El Hefni</li>
</ul>
</html>", info="<html>
<p><b>ThermoSysPro Version 4.1</h4>
</HTML>"));
end DryAirIdealGas;
