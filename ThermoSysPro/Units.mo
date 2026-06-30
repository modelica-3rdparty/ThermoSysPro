within ThermoSysPro;
package Units "Additional SI and non-SI units"
  package SI "Library of type and unit definitions based on SI units according to ISO 31-1992"
    extends Modelica.Icons.Package;
    // Space and Time (chapter 1 of ISO 31-1992)
    type Angle = Real(final quantity = "Angle", final unit = "rad", displayUnit = "deg") annotation (
      Documentation(info = "## Copyright © EDF 2002 - 2025

## ThermoSysPro Version 4.2

      "));
    type SolidAngle = Real(final quantity = "SolidAngle", final unit = "sr") annotation (
      Documentation(info = "## Copyright © EDF 2002 - 2025

## ThermoSysPro Version 4.2

      "));
    type Length = Real(final quantity = "Length", final unit = "m") annotation (
      Documentation(info = "## Copyright © EDF 2002 - 2025

## ThermoSysPro Version 4.2

      "));
    type PathLength = Length annotation (
      Documentation(info = "## Copyright © EDF 2002 - 2025

## ThermoSysPro Version 4.2

      "));
    type Position = Length annotation (
      Documentation(info = "## Copyright © EDF 2002 - 2025

## ThermoSysPro Version 4.2

      "));
    type Distance = Length(min = 0) annotation (
      Documentation(info = "## Copyright © EDF 2002 - 2025

## ThermoSysPro Version 4.2

      "));
    type Breadth = Length(min = 0) annotation (
      Documentation(info = "## Copyright © EDF 2002 - 2025

## ThermoSysPro Version 4.2

      "));
    type Height = Length(min = 0) annotation (
      Documentation(info = "## Copyright © EDF 2002 - 2025

## ThermoSysPro Version 4.2

      "));
    type Thickness = Length(min = 0) annotation (
      Documentation(info = "## Copyright © EDF 2002 - 2025

## ThermoSysPro Version 4.2

      "));
    type Radius = Length(min = 0) annotation (
      Documentation(info = "## Copyright © EDF 2002 - 2025

## ThermoSysPro Version 4.2

      "));
    type Diameter = Length(min = 0) annotation (
      Documentation(info = "## Copyright © EDF 2002 - 2025

## ThermoSysPro Version 4.2

      "));
    type Area = Real(final quantity = "Area", final unit = "m2") annotation (
      Documentation(info = "## Copyright © EDF 2002 - 2025

## ThermoSysPro Version 4.2

      "));
    type Volume = Real(final quantity = "Volume", final unit = "m3") annotation (
      Documentation(info = "## Copyright © EDF 2002 - 2025

## ThermoSysPro Version 4.2

      "));
    type Time = Real(final quantity = "Time", final unit = "s") annotation (
      Documentation(info = "## Copyright © EDF 2002 - 2025

## ThermoSysPro Version 4.2

      "));
    type Duration = Time annotation (
      Documentation(info = "## Copyright © EDF 2002 - 2025

## ThermoSysPro Version 4.2

      "));
    type AngularVelocity = Real(final quantity = "AngularVelocity", final unit = "rad/s") annotation (
      Documentation(info = "## Copyright © EDF 2002 - 2025

## ThermoSysPro Version 4.2

      "));
    type AngularAcceleration = Real(final quantity = "AngularAcceleration", final unit = "rad/s2") annotation (
      Documentation(info = "## Copyright © EDF 2002 - 2025

## ThermoSysPro Version 4.2

      "));
    type Velocity = Real(final quantity = "Velocity", final unit = "m/s") annotation (
      Documentation(info = "## Copyright © EDF 2002 - 2025

## ThermoSysPro Version 4.2

      "));
    type Acceleration = Real(final quantity = "Acceleration", final unit = "m/s2") annotation (
      Documentation(info = "## Copyright © EDF 2002 - 2025

## ThermoSysPro Version 4.2

      "));
    // Periodic and related phenomens (chapter 2 of ISO 31-1992)
    type Period = Real(final quantity = "Time", final unit = "s") annotation (
      Documentation(info = "## Copyright © EDF 2002 - 2025

## ThermoSysPro Version 4.2

      "));
    type Frequency = Real(final quantity = "Frequency", final unit = "Hz") annotation (
      Documentation(info = "## Copyright © EDF 2002 - 2025

## ThermoSysPro Version 4.2

      "));
    type AngularFrequency = Real(final quantity = "AngularFrequency", final unit = "rad/s") annotation (
      Documentation(info = "## Copyright © EDF 2002 - 2025

## ThermoSysPro Version 4.2

      "));
    type Wavelength = Real(final quantity = "Wavelength", final unit = "m") annotation (
      Documentation(info = "## Copyright © EDF 2002 - 2025

## ThermoSysPro Version 4.2

      "));
    type Wavelenght = Wavelength annotation (
      Documentation(info = "## Copyright © EDF 2002 - 2025

## ThermoSysPro Version 4.2

      "));
    // For compatibility reasons only
    type WaveNumber = Real(final quantity = "WaveNumber", final unit = "m-1") annotation (
      Documentation(info = "## Copyright © EDF 2002 - 2025

## ThermoSysPro Version 4.2

      "));
    type CircularWaveNumber = Real(final quantity = "CircularWaveNumber", final unit = "rad/m") annotation (
      Documentation(info = "## Copyright © EDF 2002 - 2025

## ThermoSysPro Version 4.2

      "));
    type AmplitudeLevelDifference = Real(final quantity = "AmplitudeLevelDifference", final unit = "dB") annotation (
      Documentation(info = "## Copyright © EDF 2002 - 2025

## ThermoSysPro Version 4.2

      "));
    type PowerLevelDifference = Real(final quantity = "PowerLevelDifference", final unit = "dB") annotation (
      Documentation(info = "## Copyright © EDF 2002 - 2025

## ThermoSysPro Version 4.2

      "));
    type DampingCoefficient = Real(final quantity = "DampingCoefficient", final unit = "s-1") annotation (
      Documentation(info = "## Copyright © EDF 2002 - 2025

## ThermoSysPro Version 4.2

      "));
    type LogarithmicDecrement = Real(final quantity = "LogarithmicDecrement", final unit = "1/S") annotation (
      Documentation(info = "## Copyright © EDF 2002 - 2025

## ThermoSysPro Version 4.2

      "));
    type AttenuationCoefficient = Real(final quantity = "AttenuationCoefficient", final unit = "m-1") annotation (
      Documentation(info = "## Copyright © EDF 2002 - 2025

## ThermoSysPro Version 4.2

      "));
    type PhaseCoefficient = Real(final quantity = "PhaseCoefficient", final unit = "m-1") annotation (
      Documentation(info = "## Copyright © EDF 2002 - 2025

## ThermoSysPro Version 4.2

      "));
    type PropagationCoefficient = Real(final quantity = "PropagationCoefficient", final unit = "m-1") annotation (
      Documentation(info = "## Copyright © EDF 2002 - 2025

## ThermoSysPro Version 4.2

      "));
    // added to ISO-chapter
    type Damping = DampingCoefficient annotation (
      Documentation(info = "## Copyright © EDF 2002 - 2025

## ThermoSysPro Version 4.2

      "));
    // Mechanics (chapter 3 of ISO 31-1992)
    type Mass = Real(quantity = "Mass", final unit = "kg", min = 0) annotation (
      Documentation(info = "## Copyright © EDF 2002 - 2025

## ThermoSysPro Version 4.2

      "));
    type Density = Real(final quantity = "Density", final unit = "kg/m3", displayUnit = "g/cm3", min = 0.0) annotation (
      Documentation(info = "## Copyright © EDF 2002 - 2025

## ThermoSysPro Version 4.2

      "));
    type RelativeDensity = Real(final quantity = "RelativeDensity", final unit = "1", min = 0.0) annotation (
      Documentation(info = "## Copyright © EDF 2002 - 2025

## ThermoSysPro Version 4.2

      "));
    type SpecificVolume = Real(final quantity = "SpecificVolume", final unit = "m3/kg", min = 0.0) annotation (
      Documentation(info = "## Copyright © EDF 2002 - 2025

## ThermoSysPro Version 4.2

      "));
    type LinearDensity = Real(final quantity = "LinearDensity", final unit = "kg/m", min = 0) annotation (
      Documentation(info = "## Copyright © EDF 2002 - 2025

## ThermoSysPro Version 4.2

      "));
    type SurfaceDensity = Real(final quantity = "SurfaceDensity", final unit = "kg/m2", min = 0) annotation (
      Documentation(info = "## Copyright © EDF 2002 - 2025

## ThermoSysPro Version 4.2

      "));
    type Momentum = Real(final quantity = "Momentum", final unit = "kg.m/s") annotation (
      Documentation(info = "## Copyright © EDF 2002 - 2025

## ThermoSysPro Version 4.2

      "));
    type Impulse = Real(final quantity = "Impulse", final unit = "N.s") annotation (
      Documentation(info = "## Copyright © EDF 2002 - 2025

## ThermoSysPro Version 4.2

      "));
    type AngularMomentum = Real(final quantity = "AngularMomentum", final unit = "kg.m2/s") annotation (
      Documentation(info = "## Copyright © EDF 2002 - 2025

## ThermoSysPro Version 4.2

      "));
    type AngularImpulse = Real(final quantity = "AngularImpulse", final unit = "N.m.s") annotation (
      Documentation(info = "## Copyright © EDF 2002 - 2025

## ThermoSysPro Version 4.2

      "));
    type MomentOfInertia = Real(final quantity = "MomentOfInertia", final unit = "kg.m2") annotation (
      Documentation(info = "## Copyright © EDF 2002 - 2025

## ThermoSysPro Version 4.2

      "));
    type Inertia = MomentOfInertia annotation (
      Documentation(info = "## Copyright © EDF 2002 - 2025

## ThermoSysPro Version 4.2

      "));
    type Force = Real(final quantity = "Force", final unit = "N") annotation (
      Documentation(info = "## Copyright © EDF 2002 - 2025

## ThermoSysPro Version 4.2

      "));
    type TranslationalSpringConstant = Real(final quantity = "TranslationalSpringConstant", final unit = "N/m") annotation (
      Documentation(info = "## Copyright © EDF 2002 - 2025

## ThermoSysPro Version 4.2

      "));
    type TranslationalDampingConstant = Real(final quantity = "TranslationalDampingConstant", final unit = "N.s/m") annotation (
      Documentation(info = "## Copyright © EDF 2002 - 2025

## ThermoSysPro Version 4.2

      "));
    type Weight = Force annotation (
      Documentation(info = "## Copyright © EDF 2002 - 2025

## ThermoSysPro Version 4.2

      "));
    type Torque = Real(final quantity = "Torque", final unit = "N.m") annotation (
      Documentation(info = "## Copyright © EDF 2002 - 2025

## ThermoSysPro Version 4.2

      "));
    type ElectricalTorqueConstant = Real(final quantity = "ElectricalTorqueConstant", final unit = "N.m/A") annotation (
      Documentation(info = "## Copyright © EDF 2002 - 2025

## ThermoSysPro Version 4.2

      "));
    type MomentOfForce = Torque annotation (
      Documentation(info = "## Copyright © EDF 2002 - 2025

## ThermoSysPro Version 4.2

      "));
    type ImpulseFlowRate = Real(final quantity = "ImpulseFlowRate", final unit = "N") annotation (
      Documentation(info = "## Copyright © EDF 2002 - 2025

## ThermoSysPro Version 4.2

      "));
    type AngularImpulseFlowRate = Real(final quantity = "AngularImpulseFlowRate", final unit = "N.m") annotation (
      Documentation(info = "## Copyright © EDF 2002 - 2025

## ThermoSysPro Version 4.2

      "));
    type RotationalSpringConstant = Real(final quantity = "RotationalSpringConstant", final unit = "N.m/rad") annotation (
      Documentation(info = "## Copyright © EDF 2002 - 2025

## ThermoSysPro Version 4.2

      "));
    type RotationalDampingConstant = Real(final quantity = "RotationalDampingConstant", final unit = "N.m.s/rad") annotation (
      Documentation(info = "## Copyright © EDF 2002 - 2025

## ThermoSysPro Version 4.2

      "));
    type Pressure = Real(final quantity = "Pressure", final unit = "Pa", displayUnit = "bar") annotation (
      Documentation(info = "## Copyright © EDF 2002 - 2025

## ThermoSysPro Version 4.2

      "));
    type AbsolutePressure = Pressure(min = 0.0, nominal = 1e5) annotation (
      Documentation(info = "## Copyright © EDF 2002 - 2025

## ThermoSysPro Version 4.2

      "));
    type PressureDifference = Pressure annotation (
      Documentation(info = "## Copyright © EDF 2002 - 2025

## ThermoSysPro Version 4.2

      "));
    type BulkModulus = AbsolutePressure annotation (
      Documentation(info = "## Copyright © EDF 2002 - 2025

## ThermoSysPro Version 4.2

      "));
    type Stress = Real(final unit = "Pa") annotation (
      Documentation(info = "## Copyright © EDF 2002 - 2025

## ThermoSysPro Version 4.2

      "));
    type NormalStress = Stress annotation (
      Documentation(info = "## Copyright © EDF 2002 - 2025

## ThermoSysPro Version 4.2

      "));
    type ShearStress = Stress annotation (
      Documentation(info = "## Copyright © EDF 2002 - 2025

## ThermoSysPro Version 4.2

      "));
    type Strain = Real(final quantity = "Strain", final unit = "1") annotation (
      Documentation(info = "## Copyright © EDF 2002 - 2025

## ThermoSysPro Version 4.2

      "));
    type LinearStrain = Strain annotation (
      Documentation(info = "## Copyright © EDF 2002 - 2025

## ThermoSysPro Version 4.2

      "));
    type ShearStrain = Strain annotation (
      Documentation(info = "## Copyright © EDF 2002 - 2025

## ThermoSysPro Version 4.2

      "));
    type VolumeStrain = Real(final quantity = "VolumeStrain", final unit = "1") annotation (
      Documentation(info = "## Copyright © EDF 2002 - 2025

## ThermoSysPro Version 4.2

      "));
    type PoissonNumber = Real(final quantity = "PoissonNumber", final unit = "1") annotation (
      Documentation(info = "## Copyright © EDF 2002 - 2025

## ThermoSysPro Version 4.2

      "));
    type ModulusOfElasticity = Stress annotation (
      Documentation(info = "## Copyright © EDF 2002 - 2025

## ThermoSysPro Version 4.2

      "));
    type ShearModulus = Stress annotation (
      Documentation(info = "## Copyright © EDF 2002 - 2025

## ThermoSysPro Version 4.2

      "));
    type SecondMomentOfArea = Real(final quantity = "SecondMomentOfArea", final unit = "m4") annotation (
      Documentation(info = "## Copyright © EDF 2002 - 2025

## ThermoSysPro Version 4.2

      "));
    type SecondPolarMomentOfArea = SecondMomentOfArea annotation (
      Documentation(info = "## Copyright © EDF 2002 - 2025

## ThermoSysPro Version 4.2

      "));
    type SectionModulus = Real(final quantity = "SectionModulus", final unit = "m3") annotation (
      Documentation(info = "## Copyright © EDF 2002 - 2025

## ThermoSysPro Version 4.2

      "));
    type CoefficientOfFriction = Real(final quantity = "CoefficientOfFriction", final unit = "1") annotation (
      Documentation(info = "## Copyright © EDF 2002 - 2025

## ThermoSysPro Version 4.2

      "));
    type DynamicViscosity = Real(final quantity = "DynamicViscosity", final unit = "Pa.s", min = 0) annotation (
      Documentation(info = "## Copyright © EDF 2002 - 2025

## ThermoSysPro Version 4.2

      "));
    type KinematicViscosity = Real(final quantity = "KinematicViscosity", final unit = "m2/s", min = 0) annotation (
      Documentation(info = "## Copyright © EDF 2002 - 2025

## ThermoSysPro Version 4.2

      "));
    type SurfaceTension = Real(final quantity = "SurfaceTension", final unit = "N/m") annotation (
      Documentation(info = "## Copyright © EDF 2002 - 2025

## ThermoSysPro Version 4.2

      "));
    type Work = Real(final quantity = "Work", final unit = "J") annotation (
      Documentation(info = "## Copyright © EDF 2002 - 2025

## ThermoSysPro Version 4.2

      "));
    type Energy = Real(final quantity = "Energy", final unit = "J") annotation (
      Documentation(info = "## Copyright © EDF 2002 - 2025

## ThermoSysPro Version 4.2

      "));
    type EnergyDensity = Real(final quantity = "EnergyDensity", final unit = "J/m3") annotation (
      Documentation(info = "## Copyright © EDF 2002 - 2025

## ThermoSysPro Version 4.2

      "));
    type PotentialEnergy = Energy annotation (
      Documentation(info = "## Copyright © EDF 2002 - 2025

## ThermoSysPro Version 4.2

      "));
    type KineticEnergy = Energy annotation (
      Documentation(info = "## Copyright © EDF 2002 - 2025

## ThermoSysPro Version 4.2

      "));
    type Power = Real(final quantity = "Power", final unit = "W") annotation (
      Documentation(info = "## Copyright © EDF 2002 - 2025

## ThermoSysPro Version 4.2

      "));
    type EnergyFlowRate = Power annotation (
      Documentation(info = "## Copyright © EDF 2002 - 2025

## ThermoSysPro Version 4.2

      "));
    type EnthalpyFlowRate = Real(final quantity = "EnthalpyFlowRate", final unit = "W") annotation (
      Documentation(info = "## Copyright © EDF 2002 - 2025

## ThermoSysPro Version 4.2

      "));
    type Efficiency = Real(final quantity = "Efficiency", final unit = "1", min = 0) annotation (
      Documentation(info = "## Copyright © EDF 2002 - 2025

## ThermoSysPro Version 4.2

      "));
    type MassFlowRate = Real(quantity = "MassFlowRate", final unit = "kg/s") annotation (
      Documentation(info = "## Copyright © EDF 2002 - 2025

## ThermoSysPro Version 4.2

      "));
    type VolumeFlowRate = Real(final quantity = "VolumeFlowRate", final unit = "m3/s") annotation (
      Documentation(info = "## Copyright © EDF 2002 - 2025

## ThermoSysPro Version 4.2

      "));
    // added to ISO-chapter 3
    type MomentumFlux = Real(final quantity = "MomentumFlux", final unit = "N") annotation (
      Documentation(info = "## Copyright © EDF 2002 - 2025

## ThermoSysPro Version 4.2

      "));
    type AngularMomentumFlux = Real(final quantity = "AngularMomentumFlux", final unit = "N.m") annotation (
      Documentation(info = "## Copyright © EDF 2002 - 2025

## ThermoSysPro Version 4.2

      "));
    // Heat (chapter 4 of ISO 31-1992)
    type ThermodynamicTemperature = Real(final quantity = "ThermodynamicTemperature", final unit = "K", min = 0.0, start = 288.15, nominal = 300, displayUnit = "degC") "Absolute temperature (use type TemperatureDifference for relative temperatures)" annotation (
      absoluteValue = true,
      Documentation(info = "## Copyright © EDF 2002 - 2025

## ThermoSysPro Version 4.2

      "));
    type Temp_K = ThermodynamicTemperature annotation (
      Documentation(info = "## Copyright © EDF 2002 - 2025

## ThermoSysPro Version 4.2

      "));
    type Temperature = ThermodynamicTemperature annotation (
      Documentation(info = "## Copyright © EDF 2002 - 2025

## ThermoSysPro Version 4.2

      "));
    type TemperatureDifference = Real(final quantity = "ThermodynamicTemperature", final unit = "K") annotation (
      absoluteValue = false,
      Documentation(info = "## Copyright © EDF 2002 - 2025

## ThermoSysPro Version 4.2

      "));
    type TemperatureSlope = Real(final quantity = "TemperatureSlope", final unit = "K/s") annotation (
      Documentation(info = "## Copyright © EDF 2002 - 2025

## ThermoSysPro Version 4.2

      "));
    type LinearTemperatureCoefficient = Real(final quantity = "LinearTemperatureCoefficient", final unit = "1/K") annotation (
      Documentation(info = "## Copyright © EDF 2002 - 2025

## ThermoSysPro Version 4.2

      "));
    type QuadraticTemperatureCoefficient = Real(final quantity = "QuadraticTemperatureCoefficient", final unit = "1/K2") annotation (
      Documentation(info = "## Copyright © EDF 2002 - 2025

## ThermoSysPro Version 4.2

      "));
    type LinearExpansionCoefficient = Real(final quantity = "LinearExpansionCoefficient", final unit = "1/K") annotation (
      Documentation(info = "## Copyright © EDF 2002 - 2025

## ThermoSysPro Version 4.2

      "));
    type CubicExpansionCoefficient = Real(final quantity = "CubicExpansionCoefficient", final unit = "1/K") annotation (
      Documentation(info = "## Copyright © EDF 2002 - 2025

## ThermoSysPro Version 4.2

      "));
    type RelativePressureCoefficient = Real(final quantity = "RelativePressureCoefficient", final unit = "1/K") annotation (
      Documentation(info = "## Copyright © EDF 2002 - 2025

## ThermoSysPro Version 4.2

      "));
    type PressureCoefficient = Real(final quantity = "PressureCoefficient", final unit = "Pa/K") annotation (
      Documentation(info = "## Copyright © EDF 2002 - 2025

## ThermoSysPro Version 4.2

      "));
    type Compressibility = Real(final quantity = "Compressibility", final unit = "1/Pa") annotation (
      Documentation(info = "## Copyright © EDF 2002 - 2025

## ThermoSysPro Version 4.2

      "));
    type IsothermalCompressibility = Compressibility annotation (
      Documentation(info = "## Copyright © EDF 2002 - 2025

## ThermoSysPro Version 4.2

      "));
    type IsentropicCompressibility = Compressibility annotation (
      Documentation(info = "## Copyright © EDF 2002 - 2025

## ThermoSysPro Version 4.2

      "));
    type Heat = Real(final quantity = "Energy", final unit = "J") annotation (
      Documentation(info = "## Copyright © EDF 2002 - 2025

## ThermoSysPro Version 4.2

      "));
    type HeatFlowRate = Real(final quantity = "Power", final unit = "W") annotation (
      Documentation(info = "## Copyright © EDF 2002 - 2025

## ThermoSysPro Version 4.2

      "));
    type HeatFlux = Real(final quantity = "HeatFlux", final unit = "W/m2") annotation (
      Documentation(info = "## Copyright © EDF 2002 - 2025

## ThermoSysPro Version 4.2

      "));
    type DensityOfHeatFlowRate = Real(final quantity = "DensityOfHeatFlowRate", final unit = "W/m2") annotation (
      Documentation(info = "## Copyright © EDF 2002 - 2025

## ThermoSysPro Version 4.2

      "));
    type ThermalConductivity = Real(final quantity = "ThermalConductivity", final unit = "W/(m.K)") annotation (
      Documentation(info = "## Copyright © EDF 2002 - 2025

## ThermoSysPro Version 4.2

      "));
    type CoefficientOfHeatTransfer = Real(final quantity = "CoefficientOfHeatTransfer", final unit = "W/(m2.K)") annotation (
      Documentation(info = "## Copyright © EDF 2002 - 2025

## ThermoSysPro Version 4.2

      "));
    type SurfaceCoefficientOfHeatTransfer = CoefficientOfHeatTransfer annotation (
      Documentation(info = "## Copyright © EDF 2002 - 2025

## ThermoSysPro Version 4.2

      "));
    type ThermalInsulance = Real(final quantity = "ThermalInsulance", final unit = "m2.K/W") annotation (
      Documentation(info = "## Copyright © EDF 2002 - 2025

## ThermoSysPro Version 4.2

      "));
    type ThermalResistance = Real(final quantity = "ThermalResistance", final unit = "K/W") annotation (
      Documentation(info = "## Copyright © EDF 2002 - 2025

## ThermoSysPro Version 4.2

      "));
    type ThermalConductance = Real(final quantity = "ThermalConductance", final unit = "W/K") annotation (
      Documentation(info = "## Copyright © EDF 2002 - 2025

## ThermoSysPro Version 4.2

      "));
    type ThermalDiffusivity = Real(final quantity = "ThermalDiffusivity", final unit = "m2/s") annotation (
      Documentation(info = "## Copyright © EDF 2002 - 2025

## ThermoSysPro Version 4.2

      "));
    type HeatCapacity = Real(final quantity = "HeatCapacity", final unit = "J/K") annotation (
      Documentation(info = "## Copyright © EDF 2002 - 2025

## ThermoSysPro Version 4.2

      "));
    type SpecificHeatCapacity = Real(final quantity = "SpecificHeatCapacity", final unit = "J/(kg.K)") annotation (
      Documentation(info = "## Copyright © EDF 2002 - 2025

## ThermoSysPro Version 4.2

      "));
    type SpecificHeatCapacityAtConstantPressure = SpecificHeatCapacity annotation (
      Documentation(info = "## Copyright © EDF 2002 - 2025

## ThermoSysPro Version 4.2

      "));
    type SpecificHeatCapacityAtConstantVolume = SpecificHeatCapacity annotation (
      Documentation(info = "## Copyright © EDF 2002 - 2025

## ThermoSysPro Version 4.2

      "));
    type SpecificHeatCapacityAtSaturation = SpecificHeatCapacity annotation (
      Documentation(info = "## Copyright © EDF 2002 - 2025

## ThermoSysPro Version 4.2

      "));
    type RatioOfSpecificHeatCapacities = Real(final quantity = "RatioOfSpecificHeatCapacities", final unit = "1") annotation (
      Documentation(info = "## Copyright © EDF 2002 - 2025

## ThermoSysPro Version 4.2

      "));
    type IsentropicExponent = Real(final quantity = "IsentropicExponent", final unit = "1") annotation (
      Documentation(info = "## Copyright © EDF 2002 - 2025

## ThermoSysPro Version 4.2

      "));
    type Entropy = Real(final quantity = "Entropy", final unit = "J/K") annotation (
      Documentation(info = "## Copyright © EDF 2002 - 2025

## ThermoSysPro Version 4.2

      "));
    type EntropyFlowRate = Real(final quantity = "EntropyFlowRate", final unit = "J/(K.s)") annotation (
      Documentation(info = "## Copyright © EDF 2002 - 2025

## ThermoSysPro Version 4.2

      "));
    type SpecificEntropy = Real(final quantity = "SpecificEntropy", final unit = "J/(kg.K)") annotation (
      Documentation(info = "## Copyright © EDF 2002 - 2025

## ThermoSysPro Version 4.2

      "));
    type InternalEnergy = Heat annotation (
      Documentation(info = "## Copyright © EDF 2002 - 2025

## ThermoSysPro Version 4.2

      "));
    type Enthalpy = Heat annotation (
      Documentation(info = "## Copyright © EDF 2002 - 2025

## ThermoSysPro Version 4.2

      "));
    type HelmholtzFreeEnergy = Heat annotation (
      Documentation(info = "## Copyright © EDF 2002 - 2025

## ThermoSysPro Version 4.2

      "));
    type GibbsFreeEnergy = Heat annotation (
      Documentation(info = "## Copyright © EDF 2002 - 2025

## ThermoSysPro Version 4.2

      "));
    type SpecificEnergy = Real(final quantity = "SpecificEnergy", final unit = "J/kg") annotation (
      Documentation(info = "## Copyright © EDF 2002 - 2025

## ThermoSysPro Version 4.2

      "));
    type SpecificInternalEnergy = SpecificEnergy annotation (
      Documentation(info = "## Copyright © EDF 2002 - 2025

## ThermoSysPro Version 4.2

      "));
    type SpecificEnthalpy = SpecificEnergy annotation (
      Documentation(info = "## Copyright © EDF 2002 - 2025

## ThermoSysPro Version 4.2

      "));
    type SpecificHelmholtzFreeEnergy = SpecificEnergy annotation (
      Documentation(info = "## Copyright © EDF 2002 - 2025

## ThermoSysPro Version 4.2

      "));
    type SpecificGibbsFreeEnergy = SpecificEnergy annotation (
      Documentation(info = "## Copyright © EDF 2002 - 2025

## ThermoSysPro Version 4.2

      "));
    type MassieuFunction = Real(final quantity = "MassieuFunction", final unit = "J/K") annotation (
      Documentation(info = "## Copyright © EDF 2002 - 2025

## ThermoSysPro Version 4.2

      "));
    type PlanckFunction = Real(final quantity = "PlanckFunction", final unit = "J/K") annotation (
      Documentation(info = "## Copyright © EDF 2002 - 2025

## ThermoSysPro Version 4.2

      "));
    // added to ISO-chapter 4
    type DerDensityByEnthalpy = Real(final unit = "kg.s2/m5") annotation (
      Documentation(info = "## Copyright © EDF 2002 - 2025

## ThermoSysPro Version 4.2

      "));
    type DerDensityByPressure = Real(final unit = "s2/m2") annotation (
      Documentation(info = "## Copyright © EDF 2002 - 2025

## ThermoSysPro Version 4.2

      "));
    type DerDensityByTemperature = Real(final unit = "kg/(m3.K)") annotation (
      Documentation(info = "## Copyright © EDF 2002 - 2025

## ThermoSysPro Version 4.2

      "));
    type DerEnthalpyByPressure = Real(final unit = "J.m.s2/kg2") annotation (
      Documentation(info = "## Copyright © EDF 2002 - 2025

## ThermoSysPro Version 4.2

      "));
    type DerEnergyByDensity = Real(final unit = "J.m3/kg") annotation (
      Documentation(info = "## Copyright © EDF 2002 - 2025

## ThermoSysPro Version 4.2

      "));
    type DerEnergyByPressure = Real(final unit = "J.m.s2/kg") annotation (
      Documentation(info = "## Copyright © EDF 2002 - 2025

## ThermoSysPro Version 4.2

      "));
    type DerPressureByDensity = Real(final unit = "Pa.m3/kg") annotation (
      Documentation(info = "## Copyright © EDF 2002 - 2025

## ThermoSysPro Version 4.2

      "));
    type DerPressureByTemperature = Real(final unit = "Pa/K") annotation (
      Documentation(info = "## Copyright © EDF 2002 - 2025

## ThermoSysPro Version 4.2

      "));
    // Electricity and Magnetism (chapter 5 of ISO 31-1992)
    type ElectricCurrent = Real(final quantity = "ElectricCurrent", final unit = "A") annotation (
      Documentation(info = "## Copyright © EDF 2002 - 2025

## ThermoSysPro Version 4.2

      "));
    type Current = ElectricCurrent annotation (
      Documentation(info = "## Copyright © EDF 2002 - 2025

## ThermoSysPro Version 4.2

      "));
    type CurrentSlope = Real(final quantity = "CurrentSlope", final unit = "A/s") annotation (
      Documentation(info = "## Copyright © EDF 2002 - 2025

## ThermoSysPro Version 4.2

      "));
    type ElectricCharge = Real(final quantity = "ElectricCharge", final unit = "C") annotation (
      Documentation(info = "## Copyright © EDF 2002 - 2025

## ThermoSysPro Version 4.2

      "));
    type Charge = ElectricCharge annotation (
      Documentation(info = "## Copyright © EDF 2002 - 2025

## ThermoSysPro Version 4.2

      "));
    type VolumeDensityOfCharge = Real(final quantity = "VolumeDensityOfCharge", final unit = "C/m3", min = 0) annotation (
      Documentation(info = "## Copyright © EDF 2002 - 2025

## ThermoSysPro Version 4.2

      "));
    type SurfaceDensityOfCharge = Real(final quantity = "SurfaceDensityOfCharge", final unit = "C/m2", min = 0) annotation (
      Documentation(info = "## Copyright © EDF 2002 - 2025

## ThermoSysPro Version 4.2

      "));
    type ElectricFieldStrength = Real(final quantity = "ElectricFieldStrength", final unit = "V/m") annotation (
      Documentation(info = "## Copyright © EDF 2002 - 2025

## ThermoSysPro Version 4.2

      "));
    type ElectricPotential = Real(final quantity = "ElectricPotential", final unit = "V") annotation (
      Documentation(info = "## Copyright © EDF 2002 - 2025

## ThermoSysPro Version 4.2

      "));
    type Voltage = ElectricPotential annotation (
      Documentation(info = "## Copyright © EDF 2002 - 2025

## ThermoSysPro Version 4.2

      "));
    type PotentialDifference = ElectricPotential annotation (
      Documentation(info = "## Copyright © EDF 2002 - 2025

## ThermoSysPro Version 4.2

      "));
    type ElectromotiveForce = ElectricPotential annotation (
      Documentation(info = "## Copyright © EDF 2002 - 2025

## ThermoSysPro Version 4.2

      "));
    type VoltageSecond = Real(final quantity = "VoltageSecond", final unit = "V.s") "Voltage second" annotation (
      Documentation(info = "## Copyright © EDF 2002 - 2025

## ThermoSysPro Version 4.2

      "));
    type VoltageSlope = Real(final quantity = "VoltageSlope", final unit = "V/s") annotation (
      Documentation(info = "## Copyright © EDF 2002 - 2025

## ThermoSysPro Version 4.2

      "));
    type ElectricFluxDensity = Real(final quantity = "ElectricFluxDensity", final unit = "C/m2") annotation (
      Documentation(info = "## Copyright © EDF 2002 - 2025

## ThermoSysPro Version 4.2

      "));
    type ElectricFlux = Real(final quantity = "ElectricFlux", final unit = "C") annotation (
      Documentation(info = "## Copyright © EDF 2002 - 2025

## ThermoSysPro Version 4.2

      "));
    type Capacitance = Real(final quantity = "Capacitance", final unit = "F", min = 0) annotation (
      Documentation(info = "## Copyright © EDF 2002 - 2025

## ThermoSysPro Version 4.2

      "));
    type CapacitancePerArea = Real(final quantity = "CapacitancePerArea", final unit = "F/m2") "Capacitance per area" annotation (
      Documentation(info = "## Copyright © EDF 2002 - 2025

## ThermoSysPro Version 4.2

      "));
    type Permittivity = Real(final quantity = "Permittivity", final unit = "F/m", min = 0) annotation (
      Documentation(info = "## Copyright © EDF 2002 - 2025

## ThermoSysPro Version 4.2

      "));
    type PermittivityOfVacuum = Permittivity annotation (
      Documentation(info = "## Copyright © EDF 2002 - 2025

## ThermoSysPro Version 4.2

      "));
    type RelativePermittivity = Real(final quantity = "RelativePermittivity", final unit = "1") annotation (
      Documentation(info = "## Copyright © EDF 2002 - 2025

## ThermoSysPro Version 4.2

      "));
    type ElectricSusceptibility = Real(final quantity = "ElectricSusceptibility", final unit = "1") annotation (
      Documentation(info = "## Copyright © EDF 2002 - 2025

## ThermoSysPro Version 4.2

      "));
    type ElectricPolarization = Real(final quantity = "ElectricPolarization", final unit = "C/m2") annotation (
      Documentation(info = "## Copyright © EDF 2002 - 2025

## ThermoSysPro Version 4.2

      "));
    type Electrization = Real(final quantity = "Electrization", final unit = "V/m") annotation (
      Documentation(info = "## Copyright © EDF 2002 - 2025

## ThermoSysPro Version 4.2

      "));
    type ElectricDipoleMoment = Real(final quantity = "ElectricDipoleMoment", final unit = "C.m") annotation (
      Documentation(info = "## Copyright © EDF 2002 - 2025

## ThermoSysPro Version 4.2

      "));
    type CurrentDensity = Real(final quantity = "CurrentDensity", final unit = "A/m2") annotation (
      Documentation(info = "## Copyright © EDF 2002 - 2025

## ThermoSysPro Version 4.2

      "));
    type LinearCurrentDensity = Real(final quantity = "LinearCurrentDensity", final unit = "A/m") annotation (
      Documentation(info = "## Copyright © EDF 2002 - 2025

## ThermoSysPro Version 4.2

      "));
    type MagneticFieldStrength = Real(final quantity = "MagneticFieldStrength", final unit = "A/m") annotation (
      Documentation(info = "## Copyright © EDF 2002 - 2025

## ThermoSysPro Version 4.2

      "));
    type MagneticPotential = Real(final quantity = "MagneticPotential", final unit = "A") annotation (
      Documentation(info = "## Copyright © EDF 2002 - 2025

## ThermoSysPro Version 4.2

      "));
    type MagneticPotentialDifference = Real(final quantity = "MagneticPotential", final unit = "A") annotation (
      Documentation(info = "## Copyright © EDF 2002 - 2025

## ThermoSysPro Version 4.2

      "));
    type MagnetomotiveForce = Real(final quantity = "MagnetomotiveForce", final unit = "A") annotation (
      Documentation(info = "## Copyright © EDF 2002 - 2025

## ThermoSysPro Version 4.2

      "));
    type CurrentLinkage = Real(final quantity = "CurrentLinkage", final unit = "A") annotation (
      Documentation(info = "## Copyright © EDF 2002 - 2025

## ThermoSysPro Version 4.2

      "));
    type MagneticFluxDensity = Real(final quantity = "MagneticFluxDensity", final unit = "T") annotation (
      Documentation(info = "## Copyright © EDF 2002 - 2025

## ThermoSysPro Version 4.2

      "));
    type MagneticFlux = Real(final quantity = "MagneticFlux", final unit = "Wb") annotation (
      Documentation(info = "## Copyright © EDF 2002 - 2025

## ThermoSysPro Version 4.2

      "));
    type MagneticVectorPotential = Real(final quantity = "MagneticVectorPotential", final unit = "Wb/m") annotation (
      Documentation(info = "## Copyright © EDF 2002 - 2025

## ThermoSysPro Version 4.2

      "));
    type Inductance = Real(final quantity = "Inductance", final unit = "H") annotation (
      Documentation(info = "## Copyright © EDF 2002 - 2025

## ThermoSysPro Version 4.2

      "));
    type SelfInductance = Inductance(min = 0) annotation (
      Documentation(info = "## Copyright © EDF 2002 - 2025

## ThermoSysPro Version 4.2

      "));
    type MutualInductance = Inductance annotation (
      Documentation(info = "## Copyright © EDF 2002 - 2025

## ThermoSysPro Version 4.2

      "));
    type CouplingCoefficient = Real(final quantity = "CouplingCoefficient", final unit = "1") annotation (
      Documentation(info = "## Copyright © EDF 2002 - 2025

## ThermoSysPro Version 4.2

      "));
    type LeakageCoefficient = Real(final quantity = "LeakageCoefficient", final unit = "1") annotation (
      Documentation(info = "## Copyright © EDF 2002 - 2025

## ThermoSysPro Version 4.2

      "));
    type Permeability = Real(final quantity = "Permeability", final unit = "H/m") annotation (
      Documentation(info = "## Copyright © EDF 2002 - 2025

## ThermoSysPro Version 4.2

      "));
    type PermeabilityOfVacuum = Permeability annotation (
      Documentation(info = "## Copyright © EDF 2002 - 2025

## ThermoSysPro Version 4.2

      "));
    type RelativePermeability = Real(final quantity = "RelativePermeability", final unit = "1") annotation (
      Documentation(info = "## Copyright © EDF 2002 - 2025

## ThermoSysPro Version 4.2

      "));
    type MagneticSusceptibility = Real(final quantity = "MagneticSusceptibility", final unit = "1") annotation (
      Documentation(info = "## Copyright © EDF 2002 - 2025

## ThermoSysPro Version 4.2

      "));
    type ElectromagneticMoment = Real(final quantity = "ElectromagneticMoment", final unit = "A.m2") annotation (
      Documentation(info = "## Copyright © EDF 2002 - 2025

## ThermoSysPro Version 4.2

      "));
    type MagneticDipoleMoment = Real(final quantity = "MagneticDipoleMoment", final unit = "Wb.m") annotation (
      Documentation(info = "## Copyright © EDF 2002 - 2025

## ThermoSysPro Version 4.2

      "));
    type Magnetization = Real(final quantity = "Magnetization", final unit = "A/m") annotation (
      Documentation(info = "## Copyright © EDF 2002 - 2025

## ThermoSysPro Version 4.2

      "));
    type MagneticPolarization = Real(final quantity = "MagneticPolarization", final unit = "T") annotation (
      Documentation(info = "## Copyright © EDF 2002 - 2025

## ThermoSysPro Version 4.2

      "));
    type ElectromagneticEnergyDensity = Real(final quantity = "EnergyDensity", final unit = "J/m3") annotation (
      Documentation(info = "## Copyright © EDF 2002 - 2025

## ThermoSysPro Version 4.2

      "));
    type PoyntingVector = Real(final quantity = "PoyntingVector", final unit = "W/m2") annotation (
      Documentation(info = "## Copyright © EDF 2002 - 2025

## ThermoSysPro Version 4.2

      "));
    type Resistance = Real(final quantity = "Resistance", final unit = "Ohm") annotation (
      Documentation(info = "## Copyright © EDF 2002 - 2025

## ThermoSysPro Version 4.2

      "));
    type Resistivity = Real(final quantity = "Resistivity", final unit = "Ohm.m") annotation (
      Documentation(info = "## Copyright © EDF 2002 - 2025

## ThermoSysPro Version 4.2

      "));
    type Conductivity = Real(final quantity = "Conductivity", final unit = "S/m") annotation (
      Documentation(info = "## Copyright © EDF 2002 - 2025

## ThermoSysPro Version 4.2

      "));
    type Reluctance = Real(final quantity = "Reluctance", final unit = "H-1") annotation (
      Documentation(info = "## Copyright © EDF 2002 - 2025

## ThermoSysPro Version 4.2

      "));
    type Permeance = Real(final quantity = "Permeance", final unit = "H") annotation (
      Documentation(info = "## Copyright © EDF 2002 - 2025

## ThermoSysPro Version 4.2

      "));
    type PhaseDifference = Real(final quantity = "Angle", final unit = "rad", displayUnit = "deg") annotation (
      Documentation(info = "## Copyright © EDF 2002 - 2025

## ThermoSysPro Version 4.2

      "));
    type Impedance = Resistance annotation (
      Documentation(info = "## Copyright © EDF 2002 - 2025

## ThermoSysPro Version 4.2

      "));
    type ModulusOfImpedance = Resistance annotation (
      Documentation(info = "## Copyright © EDF 2002 - 2025

## ThermoSysPro Version 4.2

      "));
    type Reactance = Resistance annotation (
      Documentation(info = "## Copyright © EDF 2002 - 2025

## ThermoSysPro Version 4.2

      "));
    type QualityFactor = Real(final quantity = "QualityFactor", final unit = "1") annotation (
      Documentation(info = "## Copyright © EDF 2002 - 2025

## ThermoSysPro Version 4.2

      "));
    type LossAngle = Real(final quantity = "Angle", final unit = "rad", displayUnit = "deg") annotation (
      Documentation(info = "## Copyright © EDF 2002 - 2025

## ThermoSysPro Version 4.2

      "));
    type Conductance = Real(final quantity = "Conductance", final unit = "S") annotation (
      Documentation(info = "## Copyright © EDF 2002 - 2025

## ThermoSysPro Version 4.2

      "));
    type Admittance = Conductance annotation (
      Documentation(info = "## Copyright © EDF 2002 - 2025

## ThermoSysPro Version 4.2

      "));
    type ModulusOfAdmittance = Conductance annotation (
      Documentation(info = "## Copyright © EDF 2002 - 2025

## ThermoSysPro Version 4.2

      "));
    type Susceptance = Conductance annotation (
      Documentation(info = "## Copyright © EDF 2002 - 2025

## ThermoSysPro Version 4.2

      "));
    type InstantaneousPower = Real(final quantity = "Power", final unit = "W") annotation (
      Documentation(info = "## Copyright © EDF 2002 - 2025

## ThermoSysPro Version 4.2

      "));
    type ActivePower = Real(final quantity = "Power", final unit = "W") annotation (
      Documentation(info = "## Copyright © EDF 2002 - 2025

## ThermoSysPro Version 4.2

      "));
    type ApparentPower = Real(final quantity = "Power", final unit = "VA") annotation (
      Documentation(info = "## Copyright © EDF 2002 - 2025

## ThermoSysPro Version 4.2

      "));
    type ReactivePower = Real(final quantity = "Power", final unit = "var") annotation (
      Documentation(info = "## Copyright © EDF 2002 - 2025

## ThermoSysPro Version 4.2

      "));
    type PowerFactor = Real(final quantity = "PowerFactor", final unit = "1") annotation (
      Documentation(info = "## Copyright © EDF 2002 - 2025

## ThermoSysPro Version 4.2

      "));
    // added to ISO-chapter 5
    type Transconductance = Real(final quantity = "Transconductance", final unit = "A/V2") annotation (
      Documentation(info = "## Copyright © EDF 2002 - 2025

## ThermoSysPro Version 4.2

      "));
    type InversePotential = Real(final quantity = "InversePotential", final unit = "1/V") annotation (
      Documentation(info = "## Copyright © EDF 2002 - 2025

## ThermoSysPro Version 4.2

      "));
    type ElectricalForceConstant = Real(final quantity = "ElectricalForceConstant", final unit = "N/A") annotation (
      Documentation(info = "## Copyright © EDF 2002 - 2025

## ThermoSysPro Version 4.2

      "));
    // Light and Related Electromagnetic Radiations (chapter 6 of ISO 31-1992)
    type RadiantEnergy = Real(final quantity = "Energy", final unit = "J") annotation (
      Documentation(info = "## Copyright © EDF 2002 - 2025

## ThermoSysPro Version 4.2

      "));
    type RadiantEnergyDensity = Real(final quantity = "EnergyDensity", final unit = "J/m3") annotation (
      Documentation(info = "## Copyright © EDF 2002 - 2025

## ThermoSysPro Version 4.2

      "));
    type SpectralRadiantEnergyDensity = Real(final quantity = "SpectralRadiantEnergyDensity", final unit = "J/m4") annotation (
      Documentation(info = "## Copyright © EDF 2002 - 2025

## ThermoSysPro Version 4.2

      "));
    type RadiantPower = Real(final quantity = "Power", final unit = "W") annotation (
      Documentation(info = "## Copyright © EDF 2002 - 2025

## ThermoSysPro Version 4.2

      "));
    type RadiantEnergyFluenceRate = Real(final quantity = "RadiantEnergyFluenceRate", final unit = "W/m2") annotation (
      Documentation(info = "## Copyright © EDF 2002 - 2025

## ThermoSysPro Version 4.2

      "));
    type RadiantIntensity = Real(final quantity = "RadiantIntensity", final unit = "W/sr") annotation (
      Documentation(info = "## Copyright © EDF 2002 - 2025

## ThermoSysPro Version 4.2

      "));
    type Radiance = Real(final quantity = "Radiance", final unit = "W/(sr.m2)") annotation (
      Documentation(info = "## Copyright © EDF 2002 - 2025

## ThermoSysPro Version 4.2

      "));
    type RadiantExtiance = Real(final quantity = "RadiantExtiance", final unit = "W/m2") annotation (
      Documentation(info = "## Copyright © EDF 2002 - 2025

## ThermoSysPro Version 4.2

      "));
    type Irradiance = Real(final quantity = "Irradiance", final unit = "W/m2") annotation (
      Documentation(info = "## Copyright © EDF 2002 - 2025

## ThermoSysPro Version 4.2

      "));
    type Emissivity = Real(final quantity = "Emissivity", final unit = "1") annotation (
      Documentation(info = "## Copyright © EDF 2002 - 2025

## ThermoSysPro Version 4.2

      "));
    type SpectralEmissivity = Real(final quantity = "SpectralEmissivity", final unit = "1") annotation (
      Documentation(info = "## Copyright © EDF 2002 - 2025

## ThermoSysPro Version 4.2

      "));
    type DirectionalSpectralEmissivity = Real(final quantity = "DirectionalSpectralEmissivity", final unit = "1") annotation (
      Documentation(info = "## Copyright © EDF 2002 - 2025

## ThermoSysPro Version 4.2

      "));
    type LuminousIntensity = Real(final quantity = "LuminousIntensity", final unit = "cd") annotation (
      Documentation(info = "## Copyright © EDF 2002 - 2025

## ThermoSysPro Version 4.2

      "));
    type LuminousFlux = Real(final quantity = "LuminousFlux", final unit = "lm") annotation (
      Documentation(info = "## Copyright © EDF 2002 - 2025

## ThermoSysPro Version 4.2

      "));
    type QuantityOfLight = Real(final quantity = "QuantityOfLight", final unit = "lm.s") annotation (
      Documentation(info = "## Copyright © EDF 2002 - 2025

## ThermoSysPro Version 4.2

      "));
    type Luminance = Real(final quantity = "Luminance", final unit = "cd/m2") annotation (
      Documentation(info = "## Copyright © EDF 2002 - 2025

## ThermoSysPro Version 4.2

      "));
    type LuminousExitance = Real(final quantity = "LuminousExitance", final unit = "lm/m2") annotation (
      Documentation(info = "## Copyright © EDF 2002 - 2025

## ThermoSysPro Version 4.2

      "));
    type Illuminance = Real(final quantity = "Illuminance", final unit = "lx") annotation (
      Documentation(info = "## Copyright © EDF 2002 - 2025

## ThermoSysPro Version 4.2

      "));
    type LightExposure = Real(final quantity = "LightExposure", final unit = "lx.s") annotation (
      Documentation(info = "## Copyright © EDF 2002 - 2025

## ThermoSysPro Version 4.2

      "));
    type LuminousEfficacy = Real(final quantity = "LuminousEfficacy", final unit = "lm/W") annotation (
      Documentation(info = "## Copyright © EDF 2002 - 2025

## ThermoSysPro Version 4.2

      "));
    type SpectralLuminousEfficacy = Real(final quantity = "SpectralLuminousEfficacy", final unit = "lm/W") annotation (
      Documentation(info = "## Copyright © EDF 2002 - 2025

## ThermoSysPro Version 4.2

      "));
    type LuminousEfficiency = Real(final quantity = "LuminousEfficiency", final unit = "1") annotation (
      Documentation(info = "## Copyright © EDF 2002 - 2025

## ThermoSysPro Version 4.2

      "));
    type SpectralLuminousEfficiency = Real(final quantity = "SpectralLuminousEfficiency", final unit = "1") annotation (
      Documentation(info = "## Copyright © EDF 2002 - 2025

## ThermoSysPro Version 4.2

      "));
    type CIESpectralTristimulusValues = Real(final quantity = "CIESpectralTristimulusValues", final unit = "1") annotation (
      Documentation(info = "## Copyright © EDF 2002 - 2025

## ThermoSysPro Version 4.2

      "));
    type ChromaticityCoordinates = Real(final quantity = "CromaticityCoordinates", final unit = "1") annotation (
      Documentation(info = "## Copyright © EDF 2002 - 2025

## ThermoSysPro Version 4.2

      "));
    type SpectralAbsorptionFactor = Real(final quantity = "SpectralAbsorptionFactor", final unit = "1") annotation (
      Documentation(info = "## Copyright © EDF 2002 - 2025

## ThermoSysPro Version 4.2

      "));
    type SpectralReflectionFactor = Real(final quantity = "SpectralReflectionFactor", final unit = "1") annotation (
      Documentation(info = "## Copyright © EDF 2002 - 2025

## ThermoSysPro Version 4.2

      "));
    type SpectralTransmissionFactor = Real(final quantity = "SpectralTransmissionFactor", final unit = "1") annotation (
      Documentation(info = "## Copyright © EDF 2002 - 2025

## ThermoSysPro Version 4.2

      "));
    type SpectralRadianceFactor = Real(final quantity = "SpectralRadianceFactor", final unit = "1") annotation (
      Documentation(info = "## Copyright © EDF 2002 - 2025

## ThermoSysPro Version 4.2

      "));
    type LinearAttenuationCoefficient = Real(final quantity = "AttenuationCoefficient", final unit = "m-1") annotation (
      Documentation(info = "## Copyright © EDF 2002 - 2025

## ThermoSysPro Version 4.2

      "));
    type LinearAbsorptionCoefficient = Real(final quantity = "LinearAbsorptionCoefficient", final unit = "m-1") annotation (
      Documentation(info = "## Copyright © EDF 2002 - 2025

## ThermoSysPro Version 4.2

      "));
    type MolarAbsorptionCoefficient = Real(final quantity = "MolarAbsorptionCoefficient", final unit = "m2/mol") annotation (
      Documentation(info = "## Copyright © EDF 2002 - 2025

## ThermoSysPro Version 4.2

      "));
    type RefractiveIndex = Real(final quantity = "RefractiveIndex", final unit = "1") annotation (
      Documentation(info = "## Copyright © EDF 2002 - 2025

## ThermoSysPro Version 4.2

      "));
    // Acoustics (chapter 7 of ISO 31-1992)
    type StaticPressure = AbsolutePressure annotation (
      Documentation(info = "## Copyright © EDF 2002 - 2025

## ThermoSysPro Version 4.2

      "));
    type SoundPressure = StaticPressure annotation (
      Documentation(info = "## Copyright © EDF 2002 - 2025

## ThermoSysPro Version 4.2

      "));
    type SoundParticleDisplacement = Real(final quantity = "Length", final unit = "m") annotation (
      Documentation(info = "## Copyright © EDF 2002 - 2025

## ThermoSysPro Version 4.2

      "));
    type SoundParticleVelocity = Real(final quantity = "Velocity", final unit = "m/s") annotation (
      Documentation(info = "## Copyright © EDF 2002 - 2025

## ThermoSysPro Version 4.2

      "));
    type SoundParticleAcceleration = Real(final quantity = "Acceleration", final unit = "m/s2") annotation (
      Documentation(info = "## Copyright © EDF 2002 - 2025

## ThermoSysPro Version 4.2

      "));
    type VelocityOfSound = Real(final quantity = "Velocity", final unit = "m/s") annotation (
      Documentation(info = "## Copyright © EDF 2002 - 2025

## ThermoSysPro Version 4.2

      "));
    type SoundEnergyDensity = Real(final quantity = "EnergyDensity", final unit = "J/m3") annotation (
      Documentation(info = "## Copyright © EDF 2002 - 2025

## ThermoSysPro Version 4.2

      "));
    type SoundPower = Real(final quantity = "Power", final unit = "W") annotation (
      Documentation(info = "## Copyright © EDF 2002 - 2025

## ThermoSysPro Version 4.2

      "));
    type SoundIntensity = Real(final quantity = "SoundIntensity", final unit = "W/m2") annotation (
      Documentation(info = "## Copyright © EDF 2002 - 2025

## ThermoSysPro Version 4.2

      "));
    type AcousticImpedance = Real(final quantity = "AcousticImpedance", final unit = "Pa.s/m3") annotation (
      Documentation(info = "## Copyright © EDF 2002 - 2025

## ThermoSysPro Version 4.2

      "));
    type SpecificAcousticImpedance = Real(final quantity = "SpecificAcousticImpedance", final unit = "Pa.s/m") annotation (
      Documentation(info = "## Copyright © EDF 2002 - 2025

## ThermoSysPro Version 4.2

      "));
    type MechanicalImpedance = Real(final quantity = "MechanicalImpedance", final unit = "N.s/m") annotation (
      Documentation(info = "## Copyright © EDF 2002 - 2025

## ThermoSysPro Version 4.2

      "));
    type SoundPressureLevel = Real(final quantity = "SoundPressureLevel", final unit = "dB") annotation (
      Documentation(info = "## Copyright © EDF 2002 - 2025

## ThermoSysPro Version 4.2

      "));
    type SoundPowerLevel = Real(final quantity = "SoundPowerLevel", final unit = "dB") annotation (
      Documentation(info = "## Copyright © EDF 2002 - 2025

## ThermoSysPro Version 4.2

      "));
    type DissipationCoefficient = Real(final quantity = "DissipationCoefficient", final unit = "1") annotation (
      Documentation(info = "## Copyright © EDF 2002 - 2025

## ThermoSysPro Version 4.2

      "));
    type ReflectionCoefficient = Real(final quantity = "ReflectionCoefficient", final unit = "1") annotation (
      Documentation(info = "## Copyright © EDF 2002 - 2025

## ThermoSysPro Version 4.2

      "));
    type TransmissionCoefficient = Real(final quantity = "TransmissionCoefficient", final unit = "1") annotation (
      Documentation(info = "## Copyright © EDF 2002 - 2025

## ThermoSysPro Version 4.2

      "));
    type AcousticAbsorptionCoefficient = Real(final quantity = "AcousticAbsorptionCoefficient", final unit = "1") annotation (
      Documentation(info = "## Copyright © EDF 2002 - 2025

## ThermoSysPro Version 4.2

      "));
    type SoundReductionIndex = Real(final quantity = "SoundReductionIndex", final unit = "dB") annotation (
      Documentation(info = "## Copyright © EDF 2002 - 2025

## ThermoSysPro Version 4.2

      "));
    type EquivalentAbsorptionArea = Real(final quantity = "Area", final unit = "m2") annotation (
      Documentation(info = "## Copyright © EDF 2002 - 2025

## ThermoSysPro Version 4.2

      "));
    type ReverberationTime = Real(final quantity = "Time", final unit = "s") annotation (
      Documentation(info = "## Copyright © EDF 2002 - 2025

## ThermoSysPro Version 4.2

      "));
    type LoudnessLevel = Real(final quantity = "LoudnessLevel", final unit = "phon") annotation (
      Documentation(info = "## Copyright © EDF 2002 - 2025

## ThermoSysPro Version 4.2

      "));
    type Loudness = Real(final quantity = "Loudness", final unit = "sone") annotation (
      Documentation(info = "## Copyright © EDF 2002 - 2025

## ThermoSysPro Version 4.2

      "));
    type LoundnessLevel = Real(final quantity = "LoundnessLevel", final unit = "phon") "Obsolete type, use LoudnessLevel instead!" annotation (
      Documentation(info = "## Copyright © EDF 2002 - 2025

## ThermoSysPro Version 4.2

      "));
    type Loundness = Real(final quantity = "Loundness", final unit = "sone") "Obsolete type, use Loudness instead!" annotation (
      Documentation(info = "## Copyright © EDF 2002 - 2025

## ThermoSysPro Version 4.2

      "));
    // Physical chemistry and molecular physics (chapter 8 of ISO 31-1992)
    type RelativeAtomicMass = Real(final quantity = "RelativeAtomicMass", final unit = "1") annotation (
      Documentation(info = "## Copyright © EDF 2002 - 2025

## ThermoSysPro Version 4.2

      "));
    type RelativeMolecularMass = Real(final quantity = "RelativeMolecularMass", final unit = "1") annotation (
      Documentation(info = "## Copyright © EDF 2002 - 2025

## ThermoSysPro Version 4.2

      "));
    type NumberOfMolecules = Real(final quantity = "NumberOfMolecules", final unit = "1") annotation (
      Documentation(info = "## Copyright © EDF 2002 - 2025

## ThermoSysPro Version 4.2

      "));
    type AmountOfSubstance = Real(final quantity = "AmountOfSubstance", final unit = "mol", min = 0) annotation (
      Documentation(info = "## Copyright © EDF 2002 - 2025

## ThermoSysPro Version 4.2

      "));
    type MolarMass = Real(final quantity = "MolarMass", final unit = "kg/mol", min = 0) annotation (
      Documentation(info = "## Copyright © EDF 2002 - 2025

## ThermoSysPro Version 4.2

      "));
    type MolarVolume = Real(final quantity = "MolarVolume", final unit = "m3/mol", min = 0) annotation (
      Documentation(info = "## Copyright © EDF 2002 - 2025

## ThermoSysPro Version 4.2

      "));
    type MolarDensity = Real(final quantity = "MolarDensity", unit = "mol/m3") annotation (
      Documentation(info = "## Copyright © EDF 2002 - 2025

## ThermoSysPro Version 4.2

      "));
    type MolarEnergy = Real(final quantity = "MolarEnergy", final unit = "J/mol", nominal = 2e4) annotation (
      Documentation(info = "## Copyright © EDF 2002 - 2025

## ThermoSysPro Version 4.2

      "));
    type MolarInternalEnergy = MolarEnergy annotation (
      Documentation(info = "## Copyright © EDF 2002 - 2025

## ThermoSysPro Version 4.2

      "));
    type MolarHeatCapacity = Real(final quantity = "MolarHeatCapacity", final unit = "J/(mol.K)") annotation (
      Documentation(info = "## Copyright © EDF 2002 - 2025

## ThermoSysPro Version 4.2

      "));
    type MolarEntropy = Real(final quantity = "MolarEntropy", final unit = "J/(mol.K)") annotation (
      Documentation(info = "## Copyright © EDF 2002 - 2025

## ThermoSysPro Version 4.2

      "));
    type MolarEnthalpy = MolarEnergy annotation (
      Documentation(info = "## Copyright © EDF 2002 - 2025

## ThermoSysPro Version 4.2

      "));
    type MolarFlowRate = Real(final quantity = "MolarFlowRate", final unit = "mol/s") annotation (
      Documentation(info = "## Copyright © EDF 2002 - 2025

## ThermoSysPro Version 4.2

      "));
    type NumberDensityOfMolecules = Real(final quantity = "NumberDensityOfMolecules", final unit = "m-3") annotation (
      Documentation(info = "## Copyright © EDF 2002 - 2025

## ThermoSysPro Version 4.2

      "));
    type MolecularConcentration = Real(final quantity = "MolecularConcentration", final unit = "m-3") annotation (
      Documentation(info = "## Copyright © EDF 2002 - 2025

## ThermoSysPro Version 4.2

      "));
    type MassConcentration = Real(final quantity = "MassConcentration", final unit = "kg/m3") annotation (
      Documentation(info = "## Copyright © EDF 2002 - 2025

## ThermoSysPro Version 4.2

      "));
    type MassFraction = Real(final quantity = "MassFraction", final unit = "1", min = 0, max = 1) annotation (
      Documentation(info = "## Copyright © EDF 2002 - 2025

## ThermoSysPro Version 4.2

      "));
    type Concentration = Real(final quantity = "Concentration", final unit = "mol/m3") annotation (
      Documentation(info = "## Copyright © EDF 2002 - 2025

## ThermoSysPro Version 4.2

      "));
    type VolumeFraction = Real(final quantity = "VolumeFraction", final unit = "1") annotation (
      Documentation(info = "## Copyright © EDF 2002 - 2025

## ThermoSysPro Version 4.2

      "));
    type MoleFraction = Real(final quantity = "MoleFraction", final unit = "1", min = 0, max = 1) annotation (
      Documentation(info = "## Copyright © EDF 2002 - 2025

## ThermoSysPro Version 4.2

      "));
    type ChemicalPotential = Real(final quantity = "ChemicalPotential", final unit = "J/mol") annotation (
      Documentation(info = "## Copyright © EDF 2002 - 2025

## ThermoSysPro Version 4.2

      "));
    type AbsoluteActivity = Real(final quantity = "AbsoluteActivity", final unit = "1") annotation (
      Documentation(info = "## Copyright © EDF 2002 - 2025

## ThermoSysPro Version 4.2

      "));
    type PartialPressure = AbsolutePressure annotation (
      Documentation(info = "## Copyright © EDF 2002 - 2025

## ThermoSysPro Version 4.2

      "));
    type Fugacity = Real(final quantity = "Fugacity", final unit = "Pa") annotation (
      Documentation(info = "## Copyright © EDF 2002 - 2025

## ThermoSysPro Version 4.2

      "));
    type StandardAbsoluteActivity = Real(final quantity = "StandardAbsoluteActivity", final unit = "1") annotation (
      Documentation(info = "## Copyright © EDF 2002 - 2025

## ThermoSysPro Version 4.2

      "));
    type ActivityCoefficient = Real(final quantity = "ActivityCoefficient", final unit = "1") annotation (
      Documentation(info = "## Copyright © EDF 2002 - 2025

## ThermoSysPro Version 4.2

      "));
    type ActivityOfSolute = Real(final quantity = "ActivityOfSolute", final unit = "1") annotation (
      Documentation(info = "## Copyright © EDF 2002 - 2025

## ThermoSysPro Version 4.2

      "));
    type ActivityCoefficientOfSolute = Real(final quantity = "ActivityCoefficientOfSolute", final unit = "1") annotation (
      Documentation(info = "## Copyright © EDF 2002 - 2025

## ThermoSysPro Version 4.2

      "));
    type StandardAbsoluteActivityOfSolute = Real(final quantity = "StandardAbsoluteActivityOfSolute", final unit = "1") annotation (
      Documentation(info = "## Copyright © EDF 2002 - 2025

## ThermoSysPro Version 4.2

      "));
    type ActivityOfSolvent = Real(final quantity = "ActivityOfSolvent", final unit = "1") annotation (
      Documentation(info = "## Copyright © EDF 2002 - 2025

## ThermoSysPro Version 4.2

      "));
    type OsmoticCoefficientOfSolvent = Real(final quantity = "OsmoticCoefficientOfSolvent", final unit = "1") annotation (
      Documentation(info = "## Copyright © EDF 2002 - 2025

## ThermoSysPro Version 4.2

      "));
    type StandardAbsoluteActivityOfSolvent = Real(final quantity = "StandardAbsoluteActivityOfSolvent", final unit = "1") annotation (
      Documentation(info = "## Copyright © EDF 2002 - 2025

## ThermoSysPro Version 4.2

      "));
    type OsmoticPressure = Real(final quantity = "Pressure", final unit = "Pa", displayUnit = "bar", min = 0) annotation (
      Documentation(info = "## Copyright © EDF 2002 - 2025

## ThermoSysPro Version 4.2

      "));
    type StoichiometricNumber = Real(final quantity = "StoichiometricNumber", final unit = "1") annotation (
      Documentation(info = "## Copyright © EDF 2002 - 2025

## ThermoSysPro Version 4.2

      "));
    type Affinity = Real(final quantity = "Affinity", final unit = "J/mol") annotation (
      Documentation(info = "## Copyright © EDF 2002 - 2025

## ThermoSysPro Version 4.2

      "));
    type MassOfMolecule = Real(final quantity = "Mass", final unit = "kg") annotation (
      Documentation(info = "## Copyright © EDF 2002 - 2025

## ThermoSysPro Version 4.2

      "));
    type ElectricDipoleMomentOfMolecule = Real(final quantity = "ElectricDipoleMomentOfMolecule", final unit = "C.m") annotation (
      Documentation(info = "## Copyright © EDF 2002 - 2025

## ThermoSysPro Version 4.2

      "));
    type ElectricPolarizabilityOfAMolecule = Real(final quantity = "ElectricPolarizabilityOfAMolecule", final unit = "C.m2/V") annotation (
      Documentation(info = "## Copyright © EDF 2002 - 2025

## ThermoSysPro Version 4.2

      "));
    type MicrocanonicalPartitionFunction = Real(final quantity = "MicrocanonicalPartitionFunction", final unit = "1") annotation (
      Documentation(info = "## Copyright © EDF 2002 - 2025

## ThermoSysPro Version 4.2

      "));
    type CanonicalPartitionFunction = Real(final quantity = "CanonicalPartitionFunction", final unit = "1") annotation (
      Documentation(info = "## Copyright © EDF 2002 - 2025

## ThermoSysPro Version 4.2

      "));
    type GrandCanonicalPartitionFunction = Real(final quantity = "GrandCanonicalPartitionFunction", final unit = "1") annotation (
      Documentation(info = "## Copyright © EDF 2002 - 2025

## ThermoSysPro Version 4.2

      "));
    type MolecularPartitionFunction = Real(final quantity = "MolecularPartitionFunction", final unit = "1") annotation (
      Documentation(info = "## Copyright © EDF 2002 - 2025

## ThermoSysPro Version 4.2

      "));
    type StatisticalWeight = Real(final quantity = "StatisticalWeight", final unit = "1") annotation (
      Documentation(info = "## Copyright © EDF 2002 - 2025

## ThermoSysPro Version 4.2

      "));
    type MeanFreePath = Length annotation (
      Documentation(info = "## Copyright © EDF 2002 - 2025

## ThermoSysPro Version 4.2

      "));
    type DiffusionCoefficient = Real(final quantity = "DiffusionCoefficient", final unit = "m2/s") annotation (
      Documentation(info = "## Copyright © EDF 2002 - 2025

## ThermoSysPro Version 4.2

      "));
    type ThermalDiffusionRatio = Real(final quantity = "ThermalDiffusionRatio", final unit = "1") annotation (
      Documentation(info = "## Copyright © EDF 2002 - 2025

## ThermoSysPro Version 4.2

      "));
    type ThermalDiffusionFactor = Real(final quantity = "ThermalDiffusionFactor", final unit = "1") annotation (
      Documentation(info = "## Copyright © EDF 2002 - 2025

## ThermoSysPro Version 4.2

      "));
    type ThermalDiffusionCoefficient = Real(final quantity = "ThermalDiffusionCoefficient", final unit = "m2/s") annotation (
      Documentation(info = "## Copyright © EDF 2002 - 2025

## ThermoSysPro Version 4.2

      "));
    type ElementaryCharge = Real(final quantity = "ElementaryCharge", final unit = "C") annotation (
      Documentation(info = "## Copyright © EDF 2002 - 2025

## ThermoSysPro Version 4.2

      "));
    type ChargeNumberOfIon = Real(final quantity = "ChargeNumberOfIon", final unit = "1") annotation (
      Documentation(info = "## Copyright © EDF 2002 - 2025

## ThermoSysPro Version 4.2

      "));
    type FaradayConstant = Real(final quantity = "FaradayConstant", final unit = "C/mol") annotation (
      Documentation(info = "## Copyright © EDF 2002 - 2025

## ThermoSysPro Version 4.2

      "));
    type IonicStrength = Real(final quantity = "IonicStrength", final unit = "mol/kg") annotation (
      Documentation(info = "## Copyright © EDF 2002 - 2025

## ThermoSysPro Version 4.2

      "));
    type DegreeOfDissociation = Real(final quantity = "DegreeOfDissociation", final unit = "1") annotation (
      Documentation(info = "## Copyright © EDF 2002 - 2025

## ThermoSysPro Version 4.2

      "));
    type ElectrolyticConductivity = Real(final quantity = "ElectrolyticConductivity", final unit = "S/m") annotation (
      Documentation(info = "## Copyright © EDF 2002 - 2025

## ThermoSysPro Version 4.2

      "));
    type MolarConductivity = Real(final quantity = "MolarConductivity", final unit = "S.m2/mol") annotation (
      Documentation(info = "## Copyright © EDF 2002 - 2025

## ThermoSysPro Version 4.2

      "));
    type TransportNumberOfIonic = Real(final quantity = "TransportNumberOfIonic", final unit = "1") annotation (
      Documentation(info = "## Copyright © EDF 2002 - 2025

## ThermoSysPro Version 4.2

      "));
    // Atomic and Nuclear Physics (chapter 9 of ISO 31-1992)
    type ProtonNumber = Real(final quantity = "ProtonNumber", final unit = "1") annotation (
      Documentation(info = "## Copyright © EDF 2002 - 2025

## ThermoSysPro Version 4.2

      "));
    type NeutronNumber = Real(final quantity = "NeutronNumber", final unit = "1") annotation (
      Documentation(info = "## Copyright © EDF 2002 - 2025

## ThermoSysPro Version 4.2

      "));
    type NucleonNumber = Real(final quantity = "NucleonNumber", final unit = "1") annotation (
      Documentation(info = "## Copyright © EDF 2002 - 2025

## ThermoSysPro Version 4.2

      "));
    type AtomicMassConstant = Real(final quantity = "Mass", final unit = "kg") annotation (
      Documentation(info = "## Copyright © EDF 2002 - 2025

## ThermoSysPro Version 4.2

      "));
    type MassOfElectron = Real(final quantity = "Mass", final unit = "kg") annotation (
      Documentation(info = "## Copyright © EDF 2002 - 2025

## ThermoSysPro Version 4.2

      "));
    type MassOfProton = Real(final quantity = "Mass", final unit = "kg") annotation (
      Documentation(info = "## Copyright © EDF 2002 - 2025

## ThermoSysPro Version 4.2

      "));
    type MassOfNeutron = Real(final quantity = "Mass", final unit = "kg") annotation (
      Documentation(info = "## Copyright © EDF 2002 - 2025

## ThermoSysPro Version 4.2

      "));
    type HartreeEnergy = Real(final quantity = "Energy", final unit = "J") annotation (
      Documentation(info = "## Copyright © EDF 2002 - 2025

## ThermoSysPro Version 4.2

      "));
    type MagneticMomentOfParticle = Real(final quantity = "MagneticMomentOfParticle", final unit = "A.m2") annotation (
      Documentation(info = "## Copyright © EDF 2002 - 2025

## ThermoSysPro Version 4.2

      "));
    type BohrMagneton = MagneticMomentOfParticle annotation (
      Documentation(info = "## Copyright © EDF 2002 - 2025

## ThermoSysPro Version 4.2

      "));
    type NuclearMagneton = MagneticMomentOfParticle annotation (
      Documentation(info = "## Copyright © EDF 2002 - 2025

## ThermoSysPro Version 4.2

      "));
    type GyromagneticCoefficient = Real(final quantity = "GyromagneticCoefficient", final unit = "A.m2/(J.s)") annotation (
      Documentation(info = "## Copyright © EDF 2002 - 2025

## ThermoSysPro Version 4.2

      "));
    type GFactorOfAtom = Real(final quantity = "GFactorOfAtom", final unit = "1") annotation (
      Documentation(info = "## Copyright © EDF 2002 - 2025

## ThermoSysPro Version 4.2

      "));
    type GFactorOfNucleus = Real(final quantity = "GFactorOfNucleus", final unit = "1") annotation (
      Documentation(info = "## Copyright © EDF 2002 - 2025

## ThermoSysPro Version 4.2

      "));
    type LarmorAngularFrequency = Real(final quantity = "AngularFrequency", final unit = "s-1") annotation (
      Documentation(info = "## Copyright © EDF 2002 - 2025

## ThermoSysPro Version 4.2

      "));
    type NuclearPrecessionAngularFrequency = Real(final quantity = "AngularFrequency", final unit = "s-1") annotation (
      Documentation(info = "## Copyright © EDF 2002 - 2025

## ThermoSysPro Version 4.2

      "));
    type CyclotronAngularFrequency = Real(final quantity = "AngularFrequency", final unit = "s-1") annotation (
      Documentation(info = "## Copyright © EDF 2002 - 2025

## ThermoSysPro Version 4.2

      "));
    type NuclearQuadrupoleMoment = Real(final quantity = "NuclearQuadrupoleMoment", final unit = "m2") annotation (
      Documentation(info = "## Copyright © EDF 2002 - 2025

## ThermoSysPro Version 4.2

      "));
    type NuclearRadius = Real(final quantity = "Length", final unit = "m") annotation (
      Documentation(info = "## Copyright © EDF 2002 - 2025

## ThermoSysPro Version 4.2

      "));
    type ElectronRadius = Real(final quantity = "Length", final unit = "m") annotation (
      Documentation(info = "## Copyright © EDF 2002 - 2025

## ThermoSysPro Version 4.2

      "));
    type ComptonWavelength = Real(final quantity = "Length", final unit = "m") annotation (
      Documentation(info = "## Copyright © EDF 2002 - 2025

## ThermoSysPro Version 4.2

      "));
    type MassExcess = Real(final quantity = "Mass", final unit = "kg") annotation (
      Documentation(info = "## Copyright © EDF 2002 - 2025

## ThermoSysPro Version 4.2

      "));
    type MassDefect = Real(final quantity = "Mass", final unit = "kg") annotation (
      Documentation(info = "## Copyright © EDF 2002 - 2025

## ThermoSysPro Version 4.2

      "));
    type RelativeMassExcess = Real(final quantity = "RelativeMassExcess", final unit = "1") annotation (
      Documentation(info = "## Copyright © EDF 2002 - 2025

## ThermoSysPro Version 4.2

      "));
    type RelativeMassDefect = Real(final quantity = "RelativeMassDefect", final unit = "1") annotation (
      Documentation(info = "## Copyright © EDF 2002 - 2025

## ThermoSysPro Version 4.2

      "));
    type PackingFraction = Real(final quantity = "PackingFraction", final unit = "1") annotation (
      Documentation(info = "## Copyright © EDF 2002 - 2025

## ThermoSysPro Version 4.2

      "));
    type BindingFraction = Real(final quantity = "BindingFraction", final unit = "1") annotation (
      Documentation(info = "## Copyright © EDF 2002 - 2025

## ThermoSysPro Version 4.2

      "));
    type MeanLife = Real(final quantity = "Time", final unit = "s") annotation (
      Documentation(info = "## Copyright © EDF 2002 - 2025

## ThermoSysPro Version 4.2

      "));
    type LevelWidth = Real(final quantity = "LevelWidth", final unit = "J") annotation (
      Documentation(info = "## Copyright © EDF 2002 - 2025

## ThermoSysPro Version 4.2

      "));
    type Activity = Real(final quantity = "Activity", final unit = "Bq") annotation (
      Documentation(info = "## Copyright © EDF 2002 - 2025

## ThermoSysPro Version 4.2

      "));
    type SpecificActivity = Real(final quantity = "SpecificActivity", final unit = "Bq/kg") annotation (
      Documentation(info = "## Copyright © EDF 2002 - 2025

## ThermoSysPro Version 4.2

      "));
    type DecayConstant = Real(final quantity = "DecayConstant", final unit = "s-1") annotation (
      Documentation(info = "## Copyright © EDF 2002 - 2025

## ThermoSysPro Version 4.2

      "));
    type HalfLife = Real(final quantity = "Time", final unit = "s") annotation (
      Documentation(info = "## Copyright © EDF 2002 - 2025

## ThermoSysPro Version 4.2

      "));
    type AlphaDisintegrationEnergy = Real(final quantity = "Energy", final unit = "J") annotation (
      Documentation(info = "## Copyright © EDF 2002 - 2025

## ThermoSysPro Version 4.2

      "));
    type MaximumBetaParticleEnergy = Real(final quantity = "Energy", final unit = "J") annotation (
      Documentation(info = "## Copyright © EDF 2002 - 2025

## ThermoSysPro Version 4.2

      "));
    type BetaDisintegrationEnergy = Real(final quantity = "Energy", final unit = "J") annotation (
      Documentation(info = "## Copyright © EDF 2002 - 2025

## ThermoSysPro Version 4.2

      "));
    // Nuclear Reactions and Ionizing Radiations (chapter 10 of ISO 31-1992)
    type ReactionEnergy = Real(final quantity = "Energy", final unit = "J") annotation (
      Documentation(info = "## Copyright © EDF 2002 - 2025

## ThermoSysPro Version 4.2

      "));
    type ResonanceEnergy = Real(final quantity = "Energy", final unit = "J") annotation (
      Documentation(info = "## Copyright © EDF 2002 - 2025

## ThermoSysPro Version 4.2

      "));
    type CrossSection = Real(final quantity = "Area", final unit = "m2") annotation (
      Documentation(info = "## Copyright © EDF 2002 - 2025

## ThermoSysPro Version 4.2

      "));
    type TotalCrossSection = Real(final quantity = "Area", final unit = "m2") annotation (
      Documentation(info = "## Copyright © EDF 2002 - 2025

## ThermoSysPro Version 4.2

      "));
    type AngularCrossSection = Real(final quantity = "AngularCrossSection", final unit = "m2/sr") annotation (
      Documentation(info = "## Copyright © EDF 2002 - 2025

## ThermoSysPro Version 4.2

      "));
    type SpectralCrossSection = Real(final quantity = "SpectralCrossSection", final unit = "m2/J") annotation (
      Documentation(info = "## Copyright © EDF 2002 - 2025

## ThermoSysPro Version 4.2

      "));
    type SpectralAngularCrossSection = Real(final quantity = "SpectralAngularCrossSection", final unit = "m2/(sr.J)") annotation (
      Documentation(info = "## Copyright © EDF 2002 - 2025

## ThermoSysPro Version 4.2

      "));
    type MacroscopicCrossSection = Real(final quantity = "MacroscopicCrossSection", final unit = "m-1") annotation (
      Documentation(info = "## Copyright © EDF 2002 - 2025

## ThermoSysPro Version 4.2

      "));
    type TotalMacroscopicCrossSection = Real(final quantity = "TotalMacroscopicCrossSection", final unit = "m-1") annotation (
      Documentation(info = "## Copyright © EDF 2002 - 2025

## ThermoSysPro Version 4.2

      "));
    type ParticleFluence = Real(final quantity = "ParticleFluence", final unit = "m-2") annotation (
      Documentation(info = "## Copyright © EDF 2002 - 2025

## ThermoSysPro Version 4.2

      "));
    type ParticleFluenceRate = Real(final quantity = "ParticleFluenceRate", final unit = "s-1.m2") annotation (
      Documentation(info = "## Copyright © EDF 2002 - 2025

## ThermoSysPro Version 4.2

      "));
    type EnergyFluence = Real(final quantity = "EnergyFluence", final unit = "J/m2") annotation (
      Documentation(info = "## Copyright © EDF 2002 - 2025

## ThermoSysPro Version 4.2

      "));
    type EnergyFluenceRate = Real(final quantity = "EnergyFluenceRate", final unit = "W/m2") annotation (
      Documentation(info = "## Copyright © EDF 2002 - 2025

## ThermoSysPro Version 4.2

      "));
    type CurrentDensityOfParticles = Real(final quantity = "CurrentDensityOfParticles", final unit = "m-2.s-1") annotation (
      Documentation(info = "## Copyright © EDF 2002 - 2025

## ThermoSysPro Version 4.2

      "));
    type MassAttenuationCoefficient = Real(final quantity = "MassAttenuationCoefficient", final unit = "m2/kg") annotation (
      Documentation(info = "## Copyright © EDF 2002 - 2025

## ThermoSysPro Version 4.2

      "));
    type MolarAttenuationCoefficient = Real(final quantity = "MolarAttenuationCoefficient", final unit = "m2/mol") annotation (
      Documentation(info = "## Copyright © EDF 2002 - 2025

## ThermoSysPro Version 4.2

      "));
    type AtomicAttenuationCoefficient = Real(final quantity = "AtomicAttenuationCoefficient", final unit = "m2") annotation (
      Documentation(info = "## Copyright © EDF 2002 - 2025

## ThermoSysPro Version 4.2

      "));
    type HalfThickness = Real(final quantity = "Length", final unit = "m") annotation (
      Documentation(info = "## Copyright © EDF 2002 - 2025

## ThermoSysPro Version 4.2

      "));
    type TotalLinearStoppingPower = Real(final quantity = "TotalLinearStoppingPower", final unit = "J/m") annotation (
      Documentation(info = "## Copyright © EDF 2002 - 2025

## ThermoSysPro Version 4.2

      "));
    type TotalAtomicStoppingPower = Real(final quantity = "TotalAtomicStoppingPower", final unit = "J.m2") annotation (
      Documentation(info = "## Copyright © EDF 2002 - 2025

## ThermoSysPro Version 4.2

      "));
    type TotalMassStoppingPower = Real(final quantity = "TotalMassStoppingPower", final unit = "J.m2/kg") annotation (
      Documentation(info = "## Copyright © EDF 2002 - 2025

## ThermoSysPro Version 4.2

      "));
    type MeanLinearRange = Real(final quantity = "Length", final unit = "m") annotation (
      Documentation(info = "## Copyright © EDF 2002 - 2025

## ThermoSysPro Version 4.2

      "));
    type MeanMassRange = Real(final quantity = "MeanMassRange", final unit = "kg/m2") annotation (
      Documentation(info = "## Copyright © EDF 2002 - 2025

## ThermoSysPro Version 4.2

      "));
    type LinearIonization = Real(final quantity = "LinearIonization", final unit = "m-1") annotation (
      Documentation(info = "## Copyright © EDF 2002 - 2025

## ThermoSysPro Version 4.2

      "));
    type TotalIonization = Real(final quantity = "TotalIonization", final unit = "1") annotation (
      Documentation(info = "## Copyright © EDF 2002 - 2025

## ThermoSysPro Version 4.2

      "));
    type Mobility = Real(final quantity = "Mobility", final unit = "m2/(V.s)") annotation (
      Documentation(info = "## Copyright © EDF 2002 - 2025

## ThermoSysPro Version 4.2

      "));
    type IonNumberDensity = Real(final quantity = "IonNumberDensity", final unit = "m-3") annotation (
      Documentation(info = "## Copyright © EDF 2002 - 2025

## ThermoSysPro Version 4.2

      "));
    type RecombinationCoefficient = Real(final quantity = "RecombinationCoefficient", final unit = "m3/s") annotation (
      Documentation(info = "## Copyright © EDF 2002 - 2025

## ThermoSysPro Version 4.2

      "));
    type NeutronNumberDensity = Real(final quantity = "NeutronNumberDensity", final unit = "m-3") annotation (
      Documentation(info = "## Copyright © EDF 2002 - 2025

## ThermoSysPro Version 4.2

      "));
    type NeutronSpeed = Real(final quantity = "Velocity", final unit = "m/s") annotation (
      Documentation(info = "## Copyright © EDF 2002 - 2025

## ThermoSysPro Version 4.2

      "));
    type NeutronFluenceRate = Real(final quantity = "NeutronFluenceRate", final unit = "s-1.m-2") annotation (
      Documentation(info = "## Copyright © EDF 2002 - 2025

## ThermoSysPro Version 4.2

      "));
    type TotalNeutronSourceDensity = Real(final quantity = "TotalNeutronSourceDesity", final unit = "s-1.m-3") annotation (
      Documentation(info = "## Copyright © EDF 2002 - 2025

## ThermoSysPro Version 4.2

      "));
    type SlowingDownDensity = Real(final quantity = "SlowingDownDensity", final unit = "s-1.m-3") annotation (
      Documentation(info = "## Copyright © EDF 2002 - 2025

## ThermoSysPro Version 4.2

      "));
    type ResonanceEscapeProbability = Real(final quantity = "ResonanceEscapeProbability", final unit = "1") annotation (
      Documentation(info = "## Copyright © EDF 2002 - 2025

## ThermoSysPro Version 4.2

      "));
    type Lethargy = Real(final quantity = "Lethargy", final unit = "1") annotation (
      Documentation(info = "## Copyright © EDF 2002 - 2025

## ThermoSysPro Version 4.2

      "));
    type SlowingDownArea = Real(final quantity = "Area", final unit = "m2") annotation (
      Documentation(info = "## Copyright © EDF 2002 - 2025

## ThermoSysPro Version 4.2

      "));
    type DiffusionArea = Real(final quantity = "Area", final unit = "m2") annotation (
      Documentation(info = "## Copyright © EDF 2002 - 2025

## ThermoSysPro Version 4.2

      "));
    type MigrationArea = Real(final quantity = "Area", final unit = "m2") annotation (
      Documentation(info = "## Copyright © EDF 2002 - 2025

## ThermoSysPro Version 4.2

      "));
    type SlowingDownLength = Real(final quantity = "SLength", final unit = "m") annotation (
      Documentation(info = "## Copyright © EDF 2002 - 2025

## ThermoSysPro Version 4.2

      "));
    type DiffusionLength = Length annotation (
      Documentation(info = "## Copyright © EDF 2002 - 2025

## ThermoSysPro Version 4.2

      "));
    type MigrationLength = Length annotation (
      Documentation(info = "## Copyright © EDF 2002 - 2025

## ThermoSysPro Version 4.2

      "));
    type NeutronYieldPerFission = Real(final quantity = "NeutronYieldPerFission", final unit = "1") annotation (
      Documentation(info = "## Copyright © EDF 2002 - 2025

## ThermoSysPro Version 4.2

      "));
    type NeutronYieldPerAbsorption = Real(final quantity = "NeutronYieldPerAbsorption", final unit = "1") annotation (
      Documentation(info = "## Copyright © EDF 2002 - 2025

## ThermoSysPro Version 4.2

      "));
    type FastFissionFactor = Real(final quantity = "FastFissionFactor", final unit = "1") annotation (
      Documentation(info = "## Copyright © EDF 2002 - 2025

## ThermoSysPro Version 4.2

      "));
    type ThermalUtilizationFactor = Real(final quantity = "ThermalUtilizationFactor", final unit = "1") annotation (
      Documentation(info = "## Copyright © EDF 2002 - 2025

## ThermoSysPro Version 4.2

      "));
    type NonLeakageProbability = Real(final quantity = "NonLeakageProbability", final unit = "1") annotation (
      Documentation(info = "## Copyright © EDF 2002 - 2025

## ThermoSysPro Version 4.2

      "));
    type Reactivity = Real(final quantity = "Reactivity", final unit = "1") annotation (
      Documentation(info = "## Copyright © EDF 2002 - 2025

## ThermoSysPro Version 4.2

      "));
    type ReactorTimeConstant = Real(final quantity = "Time", final unit = "s") annotation (
      Documentation(info = "## Copyright © EDF 2002 - 2025

## ThermoSysPro Version 4.2

      "));
    type EnergyImparted = Real(final quantity = "Energy", final unit = "J") annotation (
      Documentation(info = "## Copyright © EDF 2002 - 2025

## ThermoSysPro Version 4.2

      "));
    type MeanEnergyImparted = Real(final quantity = "Energy", final unit = "J") annotation (
      Documentation(info = "## Copyright © EDF 2002 - 2025

## ThermoSysPro Version 4.2

      "));
    type SpecificEnergyImparted = Real(final quantity = "SpecificEnergy", final unit = "Gy") annotation (
      Documentation(info = "## Copyright © EDF 2002 - 2025

## ThermoSysPro Version 4.2

      "));
    type AbsorbedDose = Real(final quantity = "AbsorbedDose", final unit = "Gy") annotation (
      Documentation(info = "## Copyright © EDF 2002 - 2025

## ThermoSysPro Version 4.2

      "));
    type DoseEquivalent = Real(final quantity = "DoseEquivalent", final unit = "Sv") annotation (
      Documentation(info = "## Copyright © EDF 2002 - 2025

## ThermoSysPro Version 4.2

      "));
    type AbsorbedDoseRate = Real(final quantity = "AbsorbedDoseRate", final unit = "Gy/s") annotation (
      Documentation(info = "## Copyright © EDF 2002 - 2025

## ThermoSysPro Version 4.2

      "));
    type LinearEnergyTransfer = Real(final quantity = "LinearEnergyTransfer", final unit = "J/m") annotation (
      Documentation(info = "## Copyright © EDF 2002 - 2025

## ThermoSysPro Version 4.2

      "));
    type Kerma = Real(final quantity = "Kerma", final unit = "Gy") annotation (
      Documentation(info = "## Copyright © EDF 2002 - 2025

## ThermoSysPro Version 4.2

      "));
    type KermaRate = Real(final quantity = "KermaRate", final unit = "Gy/s") annotation (
      Documentation(info = "## Copyright © EDF 2002 - 2025

## ThermoSysPro Version 4.2

      "));
    type MassEnergyTransferCoefficient = Real(final quantity = "MassEnergyTransferCoefficient", final unit = "m2/kg") annotation (
      Documentation(info = "## Copyright © EDF 2002 - 2025

## ThermoSysPro Version 4.2

      "));
    type Exposure = Real(final quantity = "Exposure", final unit = "C/kg") annotation (
      Documentation(info = "## Copyright © EDF 2002 - 2025

## ThermoSysPro Version 4.2

      "));
    type ExposureRate = Real(final quantity = "ExposureRate", final unit = "C/(kg.s)") annotation (
      Documentation(info = "## Copyright © EDF 2002 - 2025

## ThermoSysPro Version 4.2

      "));
    // chapter 11 is not defined in ISO 31-1992
    // Characteristic Numbers (chapter 12 of ISO 31-1992)
    type ReynoldsNumber = Real(final quantity = "ReynoldsNumber", final unit = "1") annotation (
      Documentation(info = "## Copyright © EDF 2002 - 2025

## ThermoSysPro Version 4.2

      "));
    type EulerNumber = Real(final quantity = "EulerNumber", final unit = "1") annotation (
      Documentation(info = "## Copyright © EDF 2002 - 2025

## ThermoSysPro Version 4.2

      "));
    type FroudeNumber = Real(final quantity = "FroudeNumber", final unit = "1") annotation (
      Documentation(info = "## Copyright © EDF 2002 - 2025

## ThermoSysPro Version 4.2

      "));
    type GrashofNumber = Real(final quantity = "GrashofNumber", final unit = "1") annotation (
      Documentation(info = "## Copyright © EDF 2002 - 2025

## ThermoSysPro Version 4.2

      "));
    type WeberNumber = Real(final quantity = "WeberNumber", final unit = "1") annotation (
      Documentation(info = "## Copyright © EDF 2002 - 2025

## ThermoSysPro Version 4.2

      "));
    type MachNumber = Real(final quantity = "MachNumber", final unit = "1") annotation (
      Documentation(info = "## Copyright © EDF 2002 - 2025

## ThermoSysPro Version 4.2

      "));
    type KnudsenNumber = Real(final quantity = "KnudsenNumber", final unit = "1") annotation (
      Documentation(info = "## Copyright © EDF 2002 - 2025

## ThermoSysPro Version 4.2

      "));
    type StrouhalNumber = Real(final quantity = "StrouhalNumber", final unit = "1") annotation (
      Documentation(info = "## Copyright © EDF 2002 - 2025

## ThermoSysPro Version 4.2

      "));
    type FourierNumber = Real(final quantity = "FourierNumber", final unit = "1") annotation (
      Documentation(info = "## Copyright © EDF 2002 - 2025

## ThermoSysPro Version 4.2

      "));
    type PecletNumber = Real(final quantity = "PecletNumber", final unit = "1") annotation (
      Documentation(info = "## Copyright © EDF 2002 - 2025

## ThermoSysPro Version 4.2

      "));
    type RayleighNumber = Real(final quantity = "RayleighNumber", final unit = "1") annotation (
      Documentation(info = "## Copyright © EDF 2002 - 2025

## ThermoSysPro Version 4.2

      "));
    type NusseltNumber = Real(final quantity = "NusseltNumber", final unit = "1") annotation (
      Documentation(info = "## Copyright © EDF 2002 - 2025

## ThermoSysPro Version 4.2

      "));
    type BiotNumber = NusseltNumber annotation (
      Documentation(info = "## Copyright © EDF 2002 - 2025

## ThermoSysPro Version 4.2

      "));
    // The Biot number (Bi) is used when
    // the Nusselt number is reserved
    // for convective transport of heat.
    type StantonNumber = Real(final quantity = "StantonNumber", final unit = "1") annotation (
      Documentation(info = "## Copyright © EDF 2002 - 2025

## ThermoSysPro Version 4.2

      "));
    type FourierNumberOfMassTransfer = Real(final quantity = "FourierNumberOfMassTransfer", final unit = "1") annotation (
      Documentation(info = "## Copyright © EDF 2002 - 2025

## ThermoSysPro Version 4.2

      "));
    type PecletNumberOfMassTransfer = Real(final quantity = "PecletNumberOfMassTransfer", final unit = "1") annotation (
      Documentation(info = "## Copyright © EDF 2002 - 2025

## ThermoSysPro Version 4.2

      "));
    type GrashofNumberOfMassTransfer = Real(final quantity = "GrashofNumberOfMassTransfer", final unit = "1") annotation (
      Documentation(info = "## Copyright © EDF 2002 - 2025

## ThermoSysPro Version 4.2

      "));
    type NusseltNumberOfMassTransfer = Real(final quantity = "NusseltNumberOfMassTransfer", final unit = "1") annotation (
      Documentation(info = "## Copyright © EDF 2002 - 2025

## ThermoSysPro Version 4.2

      "));
    type StantonNumberOfMassTransfer = Real(final quantity = "StantonNumberOfMassTransfer", final unit = "1") annotation (
      Documentation(info = "## Copyright © EDF 2002 - 2025

## ThermoSysPro Version 4.2

      "));
    type PrandtlNumber = Real(final quantity = "PrandtlNumber", final unit = "1") annotation (
      Documentation(info = "## Copyright © EDF 2002 - 2025

## ThermoSysPro Version 4.2

      "));
    type SchmidtNumber = Real(final quantity = "SchmidtNumber", final unit = "1") annotation (
      Documentation(info = "## Copyright © EDF 2002 - 2025

## ThermoSysPro Version 4.2

      "));
    type LewisNumber = Real(final quantity = "LewisNumber", final unit = "1") annotation (
      Documentation(info = "## Copyright © EDF 2002 - 2025

## ThermoSysPro Version 4.2

      "));
    type MagneticReynoldsNumber = Real(final quantity = "MagneticReynoldsNumber", final unit = "1") annotation (
      Documentation(info = "## Copyright © EDF 2002 - 2025

## ThermoSysPro Version 4.2

      "));
    type AlfvenNumber = Real(final quantity = "AlfvenNumber", final unit = "1") annotation (
      Documentation(info = "## Copyright © EDF 2002 - 2025

## ThermoSysPro Version 4.2

      "));
    type HartmannNumber = Real(final quantity = "HartmannNumber", final unit = "1") annotation (
      Documentation(info = "## Copyright © EDF 2002 - 2025

## ThermoSysPro Version 4.2

      "));
    type CowlingNumber = Real(final quantity = "CowlingNumber", final unit = "1") annotation (
      Documentation(info = "## Copyright © EDF 2002 - 2025

## ThermoSysPro Version 4.2

      "));
    // Solid State Physics (chapter 13 of ISO 31-1992)
    type BraggAngle = Angle annotation (
      Documentation(info = "## Copyright © EDF 2002 - 2025

## ThermoSysPro Version 4.2

      "));
    type OrderOfReflexion = Real(final quantity = "OrderOfReflexion", final unit = "1") annotation (
      Documentation(info = "## Copyright © EDF 2002 - 2025

## ThermoSysPro Version 4.2

      "));
    type ShortRangeOrderParameter = Real(final quantity = "RangeOrderParameter", final unit = "1") annotation (
      Documentation(info = "## Copyright © EDF 2002 - 2025

## ThermoSysPro Version 4.2

      "));
    type LongRangeOrderParameter = Real(final quantity = "RangeOrderParameter", final unit = "1") annotation (
      Documentation(info = "## Copyright © EDF 2002 - 2025

## ThermoSysPro Version 4.2

      "));
    type DebyeWallerFactor = Real(final quantity = "DebyeWallerFactor", final unit = "1") annotation (
      Documentation(info = "## Copyright © EDF 2002 - 2025

## ThermoSysPro Version 4.2

      "));
    type CircularWavenumber = Real(final quantity = "CircularWavenumber", final unit = "m-1") annotation (
      Documentation(info = "## Copyright © EDF 2002 - 2025

## ThermoSysPro Version 4.2

      "));
    type FermiCircularWavenumber = Real(final quantity = "FermiCircularWavenumber", final unit = "m-1") annotation (
      Documentation(info = "## Copyright © EDF 2002 - 2025

## ThermoSysPro Version 4.2

      "));
    type DebyeCircularWavenumber = Real(final quantity = "DebyeCircularWavenumber", final unit = "m-1") annotation (
      Documentation(info = "## Copyright © EDF 2002 - 2025

## ThermoSysPro Version 4.2

      "));
    type DebyeCircularFrequency = Real(final quantity = "AngularFrequency", final unit = "s-1") annotation (
      Documentation(info = "## Copyright © EDF 2002 - 2025

## ThermoSysPro Version 4.2

      "));
    type DebyeTemperature = ThermodynamicTemperature annotation (
      Documentation(info = "## Copyright © EDF 2002 - 2025

## ThermoSysPro Version 4.2

      "));
    type SpectralConcentration = Real(final quantity = "SpectralConcentration", final unit = "s/m3") annotation (
      Documentation(info = "## Copyright © EDF 2002 - 2025

## ThermoSysPro Version 4.2

      "));
    type GrueneisenParameter = Real(final quantity = "GrueneisenParameter", final unit = "1") annotation (
      Documentation(info = "## Copyright © EDF 2002 - 2025

## ThermoSysPro Version 4.2

      "));
    type MadelungConstant = Real(final quantity = "MadelungConstant", final unit = "1") annotation (
      Documentation(info = "## Copyright © EDF 2002 - 2025

## ThermoSysPro Version 4.2

      "));
    type DensityOfStates = Real(final quantity = "DensityOfStates", final unit = "J-1/m-3") annotation (
      Documentation(info = "## Copyright © EDF 2002 - 2025

## ThermoSysPro Version 4.2

      "));
    type ResidualResistivity = Real(final quantity = "ResidualResistivity", final unit = "Ohm.m") annotation (
      Documentation(info = "## Copyright © EDF 2002 - 2025

## ThermoSysPro Version 4.2

      "));
    type LorenzCoefficient = Real(final quantity = "LorenzCoefficient", final unit = "V2/K2") annotation (
      Documentation(info = "## Copyright © EDF 2002 - 2025

## ThermoSysPro Version 4.2

      "));
    type HallCoefficient = Real(final quantity = "HallCoefficient", final unit = "m3/C") annotation (
      Documentation(info = "## Copyright © EDF 2002 - 2025

## ThermoSysPro Version 4.2

      "));
    type ThermoelectromotiveForce = Real(final quantity = "ThermoelectromotiveForce", final unit = "V") annotation (
      Documentation(info = "## Copyright © EDF 2002 - 2025

## ThermoSysPro Version 4.2

      "));
    type SeebeckCoefficient = Real(final quantity = "SeebeckCoefficient", final unit = "V/K") annotation (
      Documentation(info = "## Copyright © EDF 2002 - 2025

## ThermoSysPro Version 4.2

      "));
    type PeltierCoefficient = Real(final quantity = "PeltierCoefficient", final unit = "V") annotation (
      Documentation(info = "## Copyright © EDF 2002 - 2025

## ThermoSysPro Version 4.2

      "));
    type ThomsonCoefficient = Real(final quantity = "ThomsonCoefficient", final unit = "V/K") annotation (
      Documentation(info = "## Copyright © EDF 2002 - 2025

## ThermoSysPro Version 4.2

      "));
    type RichardsonConstant = Real(final quantity = "RichardsonConstant", final unit = "A/(m2.K2)") annotation (
      Documentation(info = "## Copyright © EDF 2002 - 2025

## ThermoSysPro Version 4.2

      "));
    type FermiEnergy = Real(final quantity = "Energy", final unit = "eV") annotation (
      Documentation(info = "## Copyright © EDF 2002 - 2025

## ThermoSysPro Version 4.2

      "));
    type GapEnergy = Real(final quantity = "Energy", final unit = "eV") annotation (
      Documentation(info = "## Copyright © EDF 2002 - 2025

## ThermoSysPro Version 4.2

      "));
    type DonorIonizationEnergy = Real(final quantity = "Energy", final unit = "eV") annotation (
      Documentation(info = "## Copyright © EDF 2002 - 2025

## ThermoSysPro Version 4.2

      "));
    type AcceptorIonizationEnergy = Real(final quantity = "Energy", final unit = "eV") annotation (
      Documentation(info = "## Copyright © EDF 2002 - 2025

## ThermoSysPro Version 4.2

      "));
    type ActivationEnergy = Real(final quantity = "Energy", final unit = "eV") annotation (
      Documentation(info = "## Copyright © EDF 2002 - 2025

## ThermoSysPro Version 4.2

      "));
    type FermiTemperature = ThermodynamicTemperature annotation (
      Documentation(info = "## Copyright © EDF 2002 - 2025

## ThermoSysPro Version 4.2

      "));
    type ElectronNumberDensity = Real(final quantity = "ElectronNumberDensity", final unit = "m-3") annotation (
      Documentation(info = "## Copyright © EDF 2002 - 2025

## ThermoSysPro Version 4.2

      "));
    type HoleNumberDensity = Real(final quantity = "HoleNumberDensity", final unit = "m-3") annotation (
      Documentation(info = "## Copyright © EDF 2002 - 2025

## ThermoSysPro Version 4.2

      "));
    type IntrinsicNumberDensity = Real(final quantity = "IntrinsicNumberDensity", final unit = "m-3") annotation (
      Documentation(info = "## Copyright © EDF 2002 - 2025

## ThermoSysPro Version 4.2

      "));
    type DonorNumberDensity = Real(final quantity = "DonorNumberDensity", final unit = "m-3") annotation (
      Documentation(info = "## Copyright © EDF 2002 - 2025

## ThermoSysPro Version 4.2

      "));
    type AcceptorNumberDensity = Real(final quantity = "AcceptorNumberDensity", final unit = "m-3") annotation (
      Documentation(info = "## Copyright © EDF 2002 - 2025

## ThermoSysPro Version 4.2

      "));
    type EffectiveMass = Mass annotation (
      Documentation(info = "## Copyright © EDF 2002 - 2025

## ThermoSysPro Version 4.2

      "));
    type MobilityRatio = Real(final quantity = "MobilityRatio", final unit = "1") annotation (
      Documentation(info = "## Copyright © EDF 2002 - 2025

## ThermoSysPro Version 4.2

      "));
    type RelaxationTime = Time annotation (
      Documentation(info = "## Copyright © EDF 2002 - 2025

## ThermoSysPro Version 4.2

      "));
    type CarrierLifeTime = Time annotation (
      Documentation(info = "## Copyright © EDF 2002 - 2025

## ThermoSysPro Version 4.2

      "));
    type ExchangeIntegral = Real(final quantity = "Energy", final unit = "eV") annotation (
      Documentation(info = "## Copyright © EDF 2002 - 2025

## ThermoSysPro Version 4.2

      "));
    type CurieTemperature = ThermodynamicTemperature annotation (
      Documentation(info = "## Copyright © EDF 2002 - 2025

## ThermoSysPro Version 4.2

      "));
    type NeelTemperature = ThermodynamicTemperature annotation (
      Documentation(info = "## Copyright © EDF 2002 - 2025

## ThermoSysPro Version 4.2

      "));
    type LondonPenetrationDepth = Length annotation (
      Documentation(info = "## Copyright © EDF 2002 - 2025

## ThermoSysPro Version 4.2

      "));
    type CoherenceLength = Length annotation (
      Documentation(info = "## Copyright © EDF 2002 - 2025

## ThermoSysPro Version 4.2

      "));
    type LandauGinzburgParameter = Real(final quantity = "LandauGinzburgParameter", final unit = "1") annotation (
      Documentation(info = "## Copyright © EDF 2002 - 2025

## ThermoSysPro Version 4.2

      "));
    type FluxiodQuantum = Real(final quantity = "FluxiodQuantum", final unit = "Wb") annotation (
      Documentation(info = "## Copyright © EDF 2002 - 2025

## ThermoSysPro Version 4.2

      "));
    type TimeAging = Real(final quantity = "1/Time", final unit = "1/s") annotation (
      Documentation(info = "## Copyright © EDF 2002 - 2025

## ThermoSysPro Version 4.2

      "));
    type ChargeAging = Real(final quantity = "1/ElectricCharge", final unit = "1/(A.s)") annotation (
      Documentation(info = "## Copyright © EDF 2002 - 2025

## ThermoSysPro Version 4.2

      "));
    // Other types not defined in ISO 31-1992
    type PerUnit = Real(unit = "1") annotation (
      Documentation(info = "## Copyright © EDF 2002 - 2025

## ThermoSysPro Version 4.2

      "));
    type DimensionlessRatio = Real(unit = "1") annotation (
      Documentation(info = "## Copyright © EDF 2002 - 2025

## ThermoSysPro Version 4.2

      "));
    // Complex types for electrical systems (not defined in ISO 31-1992)
    operator record ComplexCurrent = Complex(redeclare ThermoSysPro.Units.SI.Current re, redeclare ThermoSysPro.Units.SI.Current im) "Complex electrical current" annotation (
      Documentation(info = "## Copyright © EDF 2002 - 2025

## ThermoSysPro Version 4.2

      "));
    operator record ComplexCurrentSlope = Complex(redeclare ThermoSysPro.Units.SI.CurrentSlope re, redeclare ThermoSysPro.Units.SI.CurrentSlope im) "Complex current slope" annotation (
      Documentation(info = "## Copyright © EDF 2002 - 2025

## ThermoSysPro Version 4.2

      "));
    operator record ComplexCurrentDensity = Complex(redeclare ThermoSysPro.Units.SI.CurrentDensity re, redeclare ThermoSysPro.Units.SI.CurrentDensity im) "Complex electrical current density" annotation (
      Documentation(info = "## Copyright © EDF 2002 - 2025

## ThermoSysPro Version 4.2

      "));
    operator record ComplexElectricPotential = Complex(redeclare ThermoSysPro.Units.SI.ElectricPotential re, redeclare ThermoSysPro.Units.SI.ElectricPotential im) "Complex electric potential" annotation (
      Documentation(info = "## Copyright © EDF 2002 - 2025

## ThermoSysPro Version 4.2

      "));
    operator record ComplexPotentialDifference = Complex(redeclare ThermoSysPro.Units.SI.PotentialDifference re, redeclare ThermoSysPro.Units.SI.PotentialDifference im) "Complex electric potential difference" annotation (
      Documentation(info = "## Copyright © EDF 2002 - 2025

## ThermoSysPro Version 4.2

      "));
    operator record ComplexVoltage = Complex(redeclare ThermoSysPro.Units.SI.Voltage re, redeclare ThermoSysPro.Units.SI.Voltage im) "Complex electrical voltage" annotation (
      Documentation(info = "## Copyright © EDF 2002 - 2025

## ThermoSysPro Version 4.2

      "));
    operator record ComplexVoltageSlope = Complex(redeclare ThermoSysPro.Units.SI.VoltageSlope re, redeclare ThermoSysPro.Units.SI.VoltageSlope im) "Complex voltage slope" annotation (
      Documentation(info = "## Copyright © EDF 2002 - 2025

## ThermoSysPro Version 4.2

      "));
    operator record ComplexElectricFieldStrength = Complex(redeclare ThermoSysPro.Units.SI.ElectricFieldStrength re, redeclare ThermoSysPro.Units.SI.ElectricFieldStrength im) "Complex electric field strength" annotation (
      Documentation(info = "## Copyright © EDF 2002 - 2025

## ThermoSysPro Version 4.2

      "));
    operator record ComplexElectricFluxDensity = Complex(redeclare ThermoSysPro.Units.SI.ElectricFluxDensity re, redeclare ThermoSysPro.Units.SI.ElectricFluxDensity im) "Complex electric flux density" annotation (
      Documentation(info = "## Copyright © EDF 2002 - 2025

## ThermoSysPro Version 4.2

      "));
    operator record ComplexElectricFlux = Complex(redeclare ThermoSysPro.Units.SI.ElectricFlux re, redeclare ThermoSysPro.Units.SI.ElectricFlux im) "Complex electric flux" annotation (
      Documentation(info = "## Copyright © EDF 2002 - 2025

## ThermoSysPro Version 4.2

      "));
    operator record ComplexMagneticFieldStrength = Complex(redeclare ThermoSysPro.Units.SI.MagneticFieldStrength re, redeclare ThermoSysPro.Units.SI.MagneticFieldStrength im) "Complex magnetic field strength" annotation (
      Documentation(info = "## Copyright © EDF 2002 - 2025

## ThermoSysPro Version 4.2

      "));
    operator record ComplexMagneticPotential = Complex(redeclare ThermoSysPro.Units.SI.MagneticPotential re, redeclare ThermoSysPro.Units.SI.MagneticPotential im) "Complex magnetic potential" annotation (
      Documentation(info = "## Copyright © EDF 2002 - 2025

## ThermoSysPro Version 4.2

      "));
    operator record ComplexMagneticPotentialDifference = Complex(redeclare ThermoSysPro.Units.SI.MagneticPotentialDifference re, redeclare ThermoSysPro.Units.SI.MagneticPotentialDifference im) "Complex magnetic potential difference" annotation (
      Documentation(info = "## Copyright © EDF 2002 - 2025

## ThermoSysPro Version 4.2

      "));
    operator record ComplexMagnetomotiveForce = Complex(redeclare ThermoSysPro.Units.SI.MagnetomotiveForce re, redeclare ThermoSysPro.Units.SI.MagnetomotiveForce im) "Complex magneto motive force" annotation (
      Documentation(info = "## Copyright © EDF 2002 - 2025

## ThermoSysPro Version 4.2

      "));
    operator record ComplexMagneticFluxDensity = Complex(redeclare ThermoSysPro.Units.SI.MagneticFluxDensity re, redeclare ThermoSysPro.Units.SI.MagneticFluxDensity im) "Complex magnetic flux density" annotation (
      Documentation(info = "## Copyright © EDF 2002 - 2025

## ThermoSysPro Version 4.2

      "));
    operator record ComplexMagneticFlux = Complex(redeclare ThermoSysPro.Units.SI.MagneticFlux re, redeclare ThermoSysPro.Units.SI.MagneticFlux im) "Complex magnetic flux" annotation (
      Documentation(info = "## Copyright © EDF 2002 - 2025

## ThermoSysPro Version 4.2

      "));
    operator record ComplexReluctance = Complex(redeclare ThermoSysPro.Units.SI.Reluctance re, redeclare ThermoSysPro.Units.SI.Reluctance im) "Complex reluctance" annotation (
      Documentation(info = "

Since magnetic material properties like reluctance and permeance often are anisotropic resp. salient,  
a special operator instead of multiplication (compare: tensor vs. vector) is required.  
Modelica.Magnetic.FundamentalWave uses a  
special record Salient  
which is only valid in the rotor-fixed coordinate system.  


Note: To avoid confusion, no magnetic material properties should be defined as Complex units.  

## Copyright © EDF 2002 - 2025

## ThermoSysPro Version 4.2

      "));
    operator record ComplexImpedance = Complex(redeclare Resistance re, redeclare Reactance im) "Complex electrical impedance" annotation (
      Documentation(info = "## Copyright © EDF 2002 - 2025

## ThermoSysPro Version 4.2

      "));
    operator record ComplexAdmittance = Complex(redeclare Conductance re, redeclare Susceptance im) "Complex electrical admittance" annotation (
      Documentation(info = "## Copyright © EDF 2002 - 2025

## ThermoSysPro Version 4.2

      "));
    operator record ComplexPower = Complex(redeclare ActivePower re, redeclare ReactivePower im) "Complex electrical power" annotation (
      Documentation(info = "## Copyright © EDF 2002 - 2025

## ThermoSysPro Version 4.2

      "));
    annotation (
      Icon(coordinateSystem(preserveAspectRatio = false, extent = {{-100, -100}, {100, 100}}), graphics={  Line(points = {{-66, 78}, {-66, -40}}, color = {64, 64, 64}), Ellipse(extent = {{12, 36}, {68, -38}}, lineColor = {64, 64, 64}, fillColor = {175, 175, 175}, fillPattern = FillPattern.Solid), Rectangle(extent = {{-74, 78}, {-66, -40}}, lineColor = {64, 64, 64}, fillColor = {175, 175, 175}, fillPattern = FillPattern.Solid), Polygon(points = {{-66, -4}, {-66, 6}, {-16, 56}, {-16, 46}, {-66, -4}}, lineColor = {64, 64, 64}, fillColor = {175, 175, 175}, fillPattern = FillPattern.Solid), Polygon(points = {{-46, 16}, {-40, 22}, {-2, -40}, {-10, -40}, {-46, 16}}, lineColor = {64, 64, 64}, fillColor = {175, 175, 175}, fillPattern = FillPattern.Solid), Ellipse(extent = {{22, 26}, {58, -28}}, lineColor = {64, 64, 64}, fillColor = {255, 255, 255}, fillPattern = FillPattern.Solid), Polygon(points = {{68, 2}, {68, -46}, {64, -60}, {58, -68}, {48, -72}, {18, -72}, {18, -64}, {46, -64}, {54, -60}, {58, -54}, {60, -46}, {60, -26}, {64, -20}, {68, -6}, {68, 2}}, lineColor = {64, 64, 64}, smooth = Smooth.Bezier, fillColor = {175, 175, 175}, fillPattern = FillPattern.Solid)}),
      Documentation(info = "
This package provides predefined types, such as Mass, Angle, Time, based on the international standard on units, e.g.,   
 type Angle = Real(final quantity = \"Angle\",  
 final unit     = \"rad\",  
                     displayUnit    = \"deg\");   
Copyright © 1998-2016, Modelica Association and DLR.   
This package is copied from package Modelica.SIunits in Modelica package version 3.2.2.  
      ", revisions = "

May 25, 2011 by Stefan Wischhusen:Added molar units for energy and enthalpy.  
Jan. 27, 2010 by Christian Kral:Added complex units.  
Dec. 14, 2005 by Martin Otter:Add User';s Guide and removed \"min\" values for Resistance and Conductance.  
October 21, 2002 by Martin Otter and Christian Schweiger:Added new package Conversions. Corrected typo Wavelenght.  
June 6, 2000 by Martin Otter:Introduced the following new typestype Temperature = ThermodynamicTemperature;types DerDensityByEnthalpy, DerDensityByPressure, DerDensityByTemperature, DerEnthalpyByPressure, DerEnergyByDensity, DerEnergyByPressureAttribute \"final\" removed from min and max values in order that these values can still be changed to narrow the allowed range of values.Quantity=\"Stress\" removed from type \"Stress\", in order that a type \"Stress\" can be connected to a type \"Pressure\".  
Oct. 27, 1999 by Martin Otter:New types due to electrical library: Transconductance, InversePotential, Damping.  
Sept. 18, 1999 by Martin Otter:Renamed from SIunit to SIunits. Subpackages expanded, i.e., the SIunits package, does no longer contain subpackages.  
Aug 12, 1999 by Martin Otter:Type \"Pressure\" renamed to \"AbsolutePressure\" and introduced a new type \"Pressure\" which does not contain a minimum of zero in order to allow convenient handling of relative pressure. Redefined BulkModulus as an alias to AbsolutePressure instead of Stress, since needed in hydraulics.  
June 29, 1999 by Martin Otter:Bug-fix: Double definition of \"Compressibility\" removed and appropriate \"extends Heat\" clause introduced in package SolidStatePhysics to incorporate ThermodynamicTemperature.  
April 8, 1998 by Martin Otter and Astrid Jaschinski:Complete ISO 31 chapters realized.  
Nov. 15, 1997 by Martin Otter and Hubertus Tummescheit:Some chapters realized.  

      "));
  end SI;

  package nonSI
    type Time_minute = Real(final quantity = "Time", final unit = "min") annotation (
      Documentation(info = "## Copyright © EDF 2002 - 2025

## ThermoSysPro Version 4.2

      "));
    type Angle_deg = Real(final quantity = "Angle", final unit = "deg") annotation (
      Documentation(info = "
Version 1.0  

## Copyright © EDF 2002 - 2025

## ThermoSysPro Version 4.2

      "));
    type AngularVelocity_rpm = Real(final quantity = "Angular velocity", final unit = "rev/min") annotation (
      Documentation(info = "
Version 1.0  

## Copyright © EDF 2002 - 2025

## ThermoSysPro Version 4.2

      "));
    type Temperature_degC = Real(final quantity = "ThermodynamicTemperature", final unit = "degC") annotation (
      Documentation(info = "
Version 1.0  

## Copyright © EDF 2002 - 2025

## ThermoSysPro Version 4.2

      "));
    type Pressure_bar = Real(final quantity = "Pressure", final unit = "bar") annotation (
      Documentation(info = "## Copyright © EDF 2002 - 2025

## ThermoSysPro Version 4.2

      "));
    type Power_kW = Real(final quantity = "Power", final unit = "kW") annotation (
      Documentation(info = "## Copyright © EDF 2002 - 2025

## ThermoSysPro Version 4.2

      "));
    type Power_MW = Real(final quantity = "Power", final unit = "MW") annotation (
      Documentation(info = "## Copyright © EDF 2002 - 2025

## ThermoSysPro Version 4.2

      "));
    type VolumeFlowRate_m3h = Real(final quantity = "VolumeFlowRate", final unit = "m3/h") annotation (
      Documentation(info = "## Copyright © EDF 2002 - 2025

## ThermoSysPro Version 4.2

      "));
    annotation (
      Documentation(info = "## Copyright © EDF 2002 - 2025

## ThermoSysPro Version 4.2

      "));
  end nonSI;

  package xSI "Additional SI units"
    type PressureLossCoefficient = Real(final quantity = "Pressure loss coefficient", final unit = "m-4") annotation (
      Documentation(info = "
Version 1.0  

## Copyright © EDF 2002 - 2025

## ThermoSysPro Version 4.2

      "));
    type DerDensityByEnthalpy = Real(final unit = "kg2/(m3.J)") annotation (
      Documentation(info = "## Copyright © EDF 2002 - 2025

## ThermoSysPro Version 4.2

      "));
    type DerDensityByEntropy = Real(final quantity = "DerDensityByEntropy", final unit = "kg2.K/(m3.J)") annotation (
      Documentation(info = "## Copyright © EDF 2002 - 2025

## ThermoSysPro Version 4.2

      "));
    type DerEnergyByTemperature = Real(final quantity = "Derivative of the specific energy wrt. the temperature", final unit = "J/(kg.K)") annotation (
      Documentation(info = "
Version 1.0  

## Copyright © EDF 2002 - 2025

## ThermoSysPro Version 4.2

      "));
    type DerEnergyByPressure = Real(final quantity = "DerEnergyByPressure", final unit = "J/Pa") annotation (
      Documentation(info = "## Copyright © EDF 2002 - 2025

## ThermoSysPro Version 4.2

      "));
    type DerEntropyByTemperature = Real(final quantity = "DerEntropyByTemperature", final unit = "J/K2") annotation (
      Documentation(info = "## Copyright © EDF 2002 - 2025

## ThermoSysPro Version 4.2

      "));
    type DerEntropyByPressure = Real(final quantity = "DerEntropyByPressure", final unit = "J/(K.Pa)") annotation (
      Documentation(info = "## Copyright © EDF 2002 - 2025

## ThermoSysPro Version 4.2

      "));
    type DerPressureByDensity = Real(final quantity = "DerPressureByDensity", final unit = "Pa.m3/kg") annotation (
      Documentation(info = "## Copyright © EDF 2002 - 2025

## ThermoSysPro Version 4.2

      "));
    type DerPressureBySpecificVolume = Real(final quantity = "DerPressureBySpecificVolume", final unit = "Pa.kg/m3") annotation (
      Documentation(info = "## Copyright © EDF 2002 - 2025

## ThermoSysPro Version 4.2

      "));
    type DerPressureByTemperature = Real(final quantity = "DerPressureByTemperature", final unit = "Pa/K") annotation (
      Documentation(info = "## Copyright © EDF 2002 - 2025

## ThermoSysPro Version 4.2

      "));
    type DerVolumeByTemperature = Real(final quantity = "DerVolumeByTemperature", final unit = "m3/K") annotation (
      Documentation(info = "## Copyright © EDF 2002 - 2025

## ThermoSysPro Version 4.2

      "));
    type DerVolumeByPressure = Real(final quantity = "DerVolumeByPressure", final unit = "m3/Pa") annotation (
      Documentation(info = "## Copyright © EDF 2002 - 2025

## ThermoSysPro Version 4.2

      "));
    type Cv = Real(final quantity = "Cv U.S.", final unit = "gpm") annotation (
      Documentation(info = "
Version 1.0  

## Copyright © EDF 2002 - 2025

## ThermoSysPro Version 4.2

      "));
    type SonicConductance = Real(final quantity = "Sonic conductance", final unit = "m3/(s.Pa)") annotation (
      Documentation(info = "
Version 1.0  

## Copyright © EDF 2002 - 2025

## ThermoSysPro Version 4.2

      "));
    type IdealGasConstant = Real(final quantity = "Ideal gas constant", final unit = "J/(kg.K)") annotation (
      Documentation(info = "## Copyright © EDF 2002 - 2025

## ThermoSysPro Version 4.2

      "));
    type ViscousFriction = Real(final quantity = "Viscous friction", final unit = "N/(m/s)") annotation (
      Documentation(info = "## Copyright © EDF 2002 - 2025

## ThermoSysPro Version 4.2

      "));
    annotation (
      Documentation(info = "## Copyright © EDF 2002 - 2025

## ThermoSysPro Version 4.2

      "));
  end xSI;
  annotation (
    Icon(graphics={  Text(extent = {{-102, 0}, {24, -26}}, lineColor = {242, 148, 0}, textString = "Thermo"), Text(extent = {{-4, 8}, {68, -34}}, lineColor = {46, 170, 220}, textString = "SysPro"), Polygon(points = {{-62, 2}, {-58, 4}, {-48, 8}, {-32, 12}, {-16, 14}, {6, 14}, {26, 12}, {42, 8}, {52, 2}, {42, 6}, {28, 10}, {6, 12}, {-12, 12}, {-16, 12}, {-34, 10}, {-50, 6}, {-62, 2}}, lineColor = {46, 170, 220}, fillColor = {46, 170, 220}, fillPattern = FillPattern.Solid), Polygon(points = {{-44, 38}, {-24, 38}, {-26, 30}, {-26, 22}, {-24, 14}, {-24, 12}, {-46, 8}, {-42, 22}, {-42, 30}, {-44, 38}}, lineColor = {46, 170, 220}, fillColor = {46, 170, 220}, fillPattern = FillPattern.Solid), Polygon(points = {{-26, 20}, {-20, 20}, {-20, 22}, {-14, 22}, {-14, 20}, {-12, 20}, {-12, 12}, {-26, 12}, {-28, 12}, {-26, 20}}, lineColor = {46, 170, 220}, fillColor = {46, 170, 220}, fillPattern = FillPattern.Solid), Polygon(points = {{-8, 14}, {-8, 24}, {-6, 24}, {-6, 14}, {-8, 14}}, lineColor = {46, 170, 220}, fillColor = {46, 170, 220}, fillPattern = FillPattern.Solid), Rectangle(extent = {{-8, 30}, {-6, 26}}, lineColor = {242, 148, 0}, fillColor = {242, 148, 0}, fillPattern = FillPattern.Solid), Rectangle(extent = {{-8, 36}, {-6, 32}}, lineColor = {242, 148, 0}, fillColor = {242, 148, 0}, fillPattern = FillPattern.Solid), Rectangle(extent = {{-8, 42}, {-6, 38}}, lineColor = {242, 148, 0}, fillColor = {242, 148, 0}, fillPattern = FillPattern.Solid), Rectangle(extent = {{-8, 48}, {-6, 44}}, lineColor = {242, 148, 0}, fillColor = {242, 148, 0}, fillPattern = FillPattern.Solid), Polygon(points = {{-4, 14}, {-4, 26}, {-2, 26}, {-2, 14}, {-4, 14}}, lineColor = {46, 170, 220}, fillColor = {46, 170, 220}, fillPattern = FillPattern.Solid), Rectangle(extent = {{-4, 32}, {-2, 28}}, lineColor = {242, 148, 0}, fillColor = {242, 148, 0}, fillPattern = FillPattern.Solid), Rectangle(extent = {{-4, 38}, {-2, 34}}, lineColor = {242, 148, 0}, fillColor = {242, 148, 0}, fillPattern = FillPattern.Solid), Rectangle(extent = {{-4, 44}, {-2, 40}}, lineColor = {242, 148, 0}, fillColor = {242, 148, 0}, fillPattern = FillPattern.Solid), Rectangle(extent = {{-4, 50}, {-2, 46}}, lineColor = {242, 148, 0}, fillColor = {242, 148, 0}, fillPattern = FillPattern.Solid), Polygon(points = {{-2, 20}, {8, 20}, {8, 22}, {10, 22}, {18, 22}, {18, 12}, {-4, 14}, {-2, 20}}, lineColor = {46, 170, 220}, fillColor = {46, 170, 220}, fillPattern = FillPattern.Solid), Polygon(points = {{-62, 2}, {-58, 4}, {-48, 8}, {-36, 10}, {-18, 12}, {6, 12}, {26, 10}, {42, 6}, {52, 0}, {42, 4}, {28, 8}, {6, 10}, {-12, 10}, {-18, 10}, {-38, 8}, {-50, 6}, {-62, 2}}, lineColor = {242, 148, 0}, fillColor = {242, 148, 0}, fillPattern = FillPattern.Solid), Line(points = {{22, 12}, {22, 14}, {22, 16}, {24, 14}, {20, 18}}, color = {46, 170, 220}, thickness = 0.5), Line(points = {{26, 12}, {26, 14}, {26, 16}, {28, 14}, {24, 18}}, color = {46, 170, 220}, thickness = 0.5), Line(points = {{30, 10}, {30, 12}, {30, 14}, {32, 12}, {28, 16}}, color = {46, 170, 220}, thickness = 0.5), Polygon(points = {{36, 8}, {36, 30}, {34, 34}, {36, 38}, {40, 38}, {40, 8}, {36, 8}}, lineColor = {46, 170, 220}, fillColor = {46, 170, 220}, fillPattern = FillPattern.Solid), Rectangle(extent = {{-100, 80}, {80, -100}}, lineColor = {0, 0, 255}), Line(points = {{-100, 80}, {-80, 100}, {100, 100}, {100, -80}, {80, -100}}, color = {0, 0, 255}, smooth = Smooth.None), Line(points = {{80, 80}, {100, 100}}, color = {0, 0, 255}, smooth = Smooth.None)}),
    Documentation(info = "
## Copyright © EDF 2002 - 2025

## ThermoSysPro Version 4.2

    "));
end Units;
