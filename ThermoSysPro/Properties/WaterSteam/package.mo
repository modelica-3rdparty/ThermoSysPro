within ThermoSysPro.Properties;

package WaterSteam "1 - Water/steam properties library (IAPWS-IF97)"
  extends ThermoSysPro.UsersGuide.Documentation.ThermoSysProPackageIcon;
  replaceable package IF97 = ThermoSysPro.Properties.WaterSteam.IF97_packages.IF97_wAJ annotation(
    Documentation(info = "## Copyright © EDF 2002 - 2025

## ThermoSysPro Version 4.2

    "));
  annotation(Window(x = 0.05, y = 0.26, width = 0.25, height = 0.25, library = 1, autolayout = 1),
    Documentation(info = "
ThermoSysPro Version 1.2   
This library implements the IAPWS-IF97 standard for the thermodynamic properties of water and steam.  
## Copyright © EDF 2002 - 2025

## ThermoSysPro Version 4.2

    "));
end WaterSteam;