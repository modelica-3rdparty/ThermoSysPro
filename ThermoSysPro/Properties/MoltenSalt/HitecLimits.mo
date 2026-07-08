within ThermoSysPro.Properties.MoltenSalt;

package HitecLimits
  extends ThermoSysPro.UsersGuide.Documentation.ThermoSysProPackageIcon;
  constant Real MINPOS = 1.0e-9 "minimal value for physical variables which are always > 0.0";
  constant Units.SI.Density DMIN = 1690.584 "Minimum density";
  constant Units.SI.Density DMAX = 1975.332 "Maximum densitye";
  constant Units.SI.Density DNOM = 1938.0 "Nominal density";
  constant Units.SI.ThermalConductivity LAMMIN = 0.239466 "Minimum thermal conductivity";
  constant Units.SI.ThermalConductivity LAMNOM = 0.46018 "Nominal thermal conductivity";
  constant Units.SI.ThermalConductivity LAMMAX = 0.493483 "Maximum thermal conductivity";
  constant Units.SI.DynamicViscosity ETAMIN = 9.93e-4 "Minimum dynamic viscosity";
  constant Units.SI.DynamicViscosity ETAMAX = 1.3e-2 "Maximum dynamic viscosity";
  constant Units.SI.DynamicViscosity ETANOM = 7.29e-3 "Nominal dynamic viscosity";
  constant Units.SI.SpecificHeatCapacity CPMIN = MINPOS "Minimum specific heat capacity";
  constant Units.SI.SpecificHeatCapacity CPMAX = Modelica.Constants.inf "Maximum specific heat capacity";
  constant Units.SI.SpecificHeatCapacity CPNOM = 1.571e3 "Nominal specific heat capacity";
  constant Units.SI.Temperature TMIN = 200 "Minimum temperature";
  constant Units.SI.Temperature TMAX = 10000 "Maximum temperature";
  constant Units.SI.Temperature TNOM = 800 "Nominal temperature";
  annotation(Documentation(info = "## Copyright © EDF 2002 - 2025

## ThermoSysPro Version 4.2

    "));
end HitecLimits;