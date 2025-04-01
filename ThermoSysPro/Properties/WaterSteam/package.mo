within ThermoSysPro.Properties;
package WaterSteam "1 - Water/steam properties library (IAPWS-IF97)"
  extends ThermoSysPro.Properties.Common.ThermoSysProIcon;



  replaceable package IF97 =
      ThermoSysPro.Properties.WaterSteam.IF97_packages.IF97_wAJ;
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
<p><b>ThermoSysPro Version 1.2</b> </p>
<p>This library implements the IAPWS-IF97 standard for the thermodynamic properties of water and steam.</h4>
</html>"));
end WaterSteam;
