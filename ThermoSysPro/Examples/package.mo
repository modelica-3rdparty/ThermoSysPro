within ThermoSysPro;
package Examples
  extends ThermoSysPro.Properties.Common.ThermoSysProIcon;




annotation (
  Window(
    x=0.05,
    y=0.01,
    width=0.25,
    height=0.25,
    library=1,
    autolayout=1),
  Icon(coordinateSystem(
      preserveAspectRatio=false,
      extent={{-100,-100},{100,100}},
      grid={2,2},
      initialScale=0.1), graphics={Text(textString="")}),
  Documentation(info="<html>
<p><b>Copyright &copy; EDF 2002 - 2024 </p>
<p><b>ThermoSysPro Version 4.1 </p>
<p>This package contains examples for the ThermoSysPro library.</h4>
</html>"));
end Examples;
