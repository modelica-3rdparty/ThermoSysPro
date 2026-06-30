within ThermoSysPro.Properties.WaterSteamSimple;

record triple "triple point data"
  extends Modelica.Icons.Record;
  constant Units.SI.Temperature Ttriple = 273.16 "the triple point temperature";
  constant Units.SI.Pressure ptriple = 611.657 "the triple point temperature";
  constant Units.SI.Density dltriple = 999.792520031617642 "the triple point liquid density";
  constant Units.SI.Density dvtriple = 0.485457572477861372e-2 "the triple point vapour density";
  annotation(
    Documentation(info = "
Record description  
Vapour/liquid/ice triple point data for IF97 steam properties.  
Version Info and Revision history  


First implemented: July, 2000  
       by Hubertus Tummescheit  


Author: Hubertus Tummescheit,   
      Modelon AB  
      Ideon Science Park  
      SE-22370 Lund, Sweden  
      email: hubertus@modelon.se  
   

Initial version: July 2000  
Documentation added: December 2002  


## Copyright © EDF 2002 - 2025

## ThermoSysPro Version 4.2

    "));
end triple;