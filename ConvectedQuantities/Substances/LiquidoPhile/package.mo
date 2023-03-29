within ThermoSysPro.ConvectedQuantities.Substances;
package LiquidoPhile "Substance tending to remain in liquid phase"
  extends None(redeclare type Concentrations = enumeration(
      substance                                                      "Gas/Liquid homogeneous substance"),
        redeclare block PhasesSeparation = PhasesSeparation_internal,
        redeclare block pH = pH_internal);

end LiquidoPhile;
