within ThermoSysPro.Properties.WaterSteamSimple;

package InitLimits
  extends ThermoSysPro.UsersGuide.Documentation.ThermoSysProPackageIcon;
  constant Real MINPOS = 1.0e-9 "minimal value for physical variables which are always > 0.0";
  constant Units.SI.Area AMIN = MINPOS "Minimum surface";
  constant Units.SI.Area AMAX = 1.0e5 "Maximum surface";
  constant Units.SI.Area ANOM = 1.0 "Nominal surface";
  constant Units.SI.Density DMIN = MINPOS "Minimum density";
  constant Units.SI.Density DMAX = 1.0e5 "Maximum densitye";
  constant Units.SI.Density DNOM = 998.0 "Nominal density";
  constant Units.SI.ThermalConductivity LAMMIN = MINPOS "Minimum thermal conductivity";
  constant Units.SI.ThermalConductivity LAMNOM = 1.0 "Nominal thermal conductivity";
  constant Units.SI.ThermalConductivity LAMMAX = 1000.0 "Maximum thermal conductivity";
  constant Units.SI.DynamicViscosity ETAMIN = MINPOS "Minimum dynamic viscosity";
  constant Units.SI.DynamicViscosity ETAMAX = 1.0e8 "Maximum dynamic viscosity";
  constant Units.SI.DynamicViscosity ETANOM = 100.0 "Nominal dynamic viscosity";
  constant Units.SI.Energy EMIN = -1.0e10 "Minimum energy";
  constant Units.SI.Energy EMAX = 1.0e10 "Maximum energy";
  constant Units.SI.Energy ENOM = 1.0e3 "Nominal energy";
  constant Units.SI.Entropy SMIN = -1.0e6 "Minimum entropy";
  constant Units.SI.Entropy SMAX = 1.0e6 "Maximum entropy";
  constant Units.SI.Entropy SNOM = 1.0e3 "Nominal entropy";
  constant Units.SI.MassFlowRate MDOTMIN = -1.0e5 "Minimum mass flow rate";
  constant Units.SI.MassFlowRate MDOTMAX = 1.0e5 "Maximum mass flow rate";
  constant Units.SI.MassFlowRate MDOTNOM = 1.0 "Nominal mass flow rate";
  constant ThermoSysPro.Units.SI.MassFraction MASSXMIN = -1.0*MINPOS "Minimum mass fraction";
  constant ThermoSysPro.Units.SI.MassFraction MASSXMAX = 1.0 "Maximum mass fraction";
  constant ThermoSysPro.Units.SI.MassFraction MASSXNOM = 0.1 "Nominal mass fraction";
  constant Units.SI.Mass MMIN = 1.0*MINPOS "Minimum mass";
  constant Units.SI.Mass MMAX = 1.0e8 "Maximum mass";
  constant Units.SI.Mass MNOM = 1.0 "Nominal mass";
  constant Units.SI.Power POWMIN = -1.0e8 "Minimum power";
  constant Units.SI.Power POWMAX = 1.0e8 "Maximum power";
  constant Units.SI.Power POWNOM = 1.0e3 "Nominal power";
  constant Units.SI.AbsolutePressure PMIN = 100.0 "Minimum pressure";
  constant Units.SI.AbsolutePressure PMAX = 1.0e9 "Maximum pressure";
  constant Units.SI.AbsolutePressure PNOM = 1.0e5 "Nominal pressure";
  constant Units.SI.AbsolutePressure COMPPMIN = -1.0*MINPOS "Minimum pressure";
  constant Units.SI.AbsolutePressure COMPPMAX = 1.0e8 "Maximum pressure";
  constant Units.SI.AbsolutePressure COMPPNOM = 1.0e5 "Nominal pressure";
  constant Units.SI.RatioOfSpecificHeatCapacities KAPPAMIN = 1.0 "Minimum isentropic exponent";
  constant Units.SI.RatioOfSpecificHeatCapacities KAPPAMAX = Modelica.Constants.inf "Maximum isentropic exponent";
  constant Units.SI.RatioOfSpecificHeatCapacities KAPPANOM = 1.2 "Nominal isentropic exponent";
  constant Units.SI.SpecificEnergy SEMIN = -1.0e8 "Minimum specific energy";
  constant Units.SI.SpecificEnergy SEMAX = 1.0e8 "Maximum specific energy";
  constant Units.SI.SpecificEnergy SENOM = 1.0e6 "Nominal specific energy";
  constant Units.SI.SpecificEnthalpy SHMIN = -1.0e6 "Minimum specific enthalpy";
  constant Units.SI.SpecificEnthalpy SHMAX = 1.0e8 "Maximum specific enthalpy";
  constant Units.SI.SpecificEnthalpy SHNOM = 1.0e6 "Nominal specific enthalpy";
  constant Units.SI.SpecificEntropy SSMIN = -1.0e6 "Minimum specific entropy";
  constant Units.SI.SpecificEntropy SSMAX = 1.0e6 "Maximum specific entropy";
  constant Units.SI.SpecificEntropy SSNOM = 1.0e3 "Nominal specific entropy";
  constant Units.SI.SpecificHeatCapacity CPMIN = MINPOS "Minimum specific heat capacity";
  constant Units.SI.SpecificHeatCapacity CPMAX = Modelica.Constants.inf "Maximum specific heat capacity";
  constant Units.SI.SpecificHeatCapacity CPNOM = 1.0e3 "Nominal specific heat capacity";
  constant Units.SI.Temperature TMIN = 200 "Minimum temperature";
  constant Units.SI.Temperature TMAX = 6000 "Maximum temperature";
  constant Units.SI.Temperature TNOM = 320.0 "Nominal temperature";
  constant Units.SI.ThermalConductivity LMIN = MINPOS "Minimum thermal conductivity";
  constant Units.SI.ThermalConductivity LMAX = 500.0 "Maximum thermal conductivity";
  constant Units.SI.ThermalConductivity LNOM = 1.0 "Nominal thermal conductivity";
  constant Units.SI.Velocity VELMIN = -1.0e5 "Minimum velocity";
  constant Units.SI.Velocity VELMAX = Modelica.Constants.inf "Maximum velocity";
  constant Units.SI.Velocity VELNOM = 1.0 "Nominal velocity";
  constant Units.SI.Volume VMIN = 0.0 "Minimum volume";
  constant Units.SI.Volume VMAX = 1.0e5 "Maximum volume";
  constant Units.SI.Volume VNOM = 1.0e-3 "Nominal volume";
  annotation(Window(x = 0.45, y = 0.01, width = 0.51, height = 0.74, library = 1, autolayout = 1),
    Documentation(info = "
Adapted from the ThermoFlow library  (H. Tummescheit)  


Version 1.0  

## Copyright © EDF 2002 - 2025

## ThermoSysPro Version 4.2

    "));
end InitLimits;