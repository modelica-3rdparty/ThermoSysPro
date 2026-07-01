within ThermoSysPro.Fluid.Examples;

package CombinedCyclePowerPlant "Models of a combined cycle power plant"
  extends ThermoSysPro.UsersGuide.Documentation.ThermoSysProPackageIcon;
  annotation(Window(x = 0.05, y = 0.01, width = 0.25, height = 0.25, library = 1, autolayout = 1), Documentation(info = "
## Copyright © EDF 2002 - 2026   
## ThermoSysPro Version 4.2   
This package contains two models of the same combined cycle power plant are provided to simulate two different transients:  

CombinedCycle_Load_100_50, to simulate a load decrease from 100% to 50%  
CombinedCycle_TripTAC, to simulate a full combustion turbine trip  

The two models are documented in two conference papers, 1 and 2.   
    "));
end CombinedCyclePowerPlant;