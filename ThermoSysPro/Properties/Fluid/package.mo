within ThermoSysPro.Properties;

package Fluid "Generic fluid properties library"
  extends ThermoSysPro.UsersGuide.Documentation.ThermoSysProPackageIcon;
  annotation(Window(x = 0.05, y = 0.26, width = 0.25, height = 0.25, library = 1, autolayout = 1),
    Documentation(info = "
ThermoSysPro Version 4.1   
This library is an interface for the following fluid properties libraries:  

Water and steam (industrial IAPWS-IF97 standard)  
C3HF5  
Flue gases  
Molten salt  
Oil  
Dry air (ideal gas)  
Water and steam (simple implementation)   

## Copyright © EDF 2002 - 2025

## ThermoSysPro Version 4.2

    "));
end Fluid;