within ThermoSysPro.Properties.WaterSteamSimple;

record critical "critical point data"
  extends Modelica.Icons.Record;
  constant Units.SI.Pressure PCRIT = 22064000.0 "the critical pressure";
  constant Units.SI.Temperature TCRIT = 647.096 "the critical temperature";
  constant Units.SI.Density DCRIT = 322.0 "the critical density";
  constant Units.SI.SpecificEnthalpy HCRIT = 2087546.84511715 "the calculated specific enthalpy at the critical point";
  constant Units.SI.SpecificEntropy SCRIT = 4412.02148223476 "the calculated specific entropy at the critical point";
  annotation(
    Documentation(info = "
Record description  
Critical point data for IF97 steam properties. SCRIT and HCRIT are calculated from helmholtz function for region 3   
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
end critical;