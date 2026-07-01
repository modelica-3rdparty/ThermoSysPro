within ThermoSysPro.Examples.Book.PowerPlants;

package CombinedCyclePowerPlant "Models of a combined cycle power plant"
  extends ThermoSysPro.UsersGuide.Documentation.ThermoSysProPackageIcon;
  annotation(Documentation(info = "
## Copyright © EDF 2002 - 2026   
## ThermoSysPro Version 4.2   
This package contains two models for a real combined cycle power plant:  

LoadVariation to simulate a load variation from 100% to 50%  
GasTurbineTrip to simulate a full gas turbine trip  

The two models are documented in Sect. 6.5 of the ThermoSysPro book.   
The results reported in the ThermoSysPro book were computed using Dymola.  
    "));
end CombinedCyclePowerPlant;