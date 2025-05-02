within ThermoSysPro.NuclearCore;
block FuelProperties
  input ThermoSysPro.Units.SI.Temperature T "Fuel Temperature";
  parameter Real porosity=0.05 "Fuel porosity";
  parameter Boolean MOX=false "Whether fuel is MOX or not";
  parameter Real pu_mFraction=0.085 "PuO2 Mass Fraction";
  parameter Real oxy_on_metal=2 "Oxyde on Metal Ratio";

  output ThermoSysPro.Units.SI.SpecificHeatCapacity cp "Fuel Specific Heat Capacity";
  output ThermoSysPro.Units.SI.ThermalConductivity k "Fuel Thermal Conductivity";

protected
  ThermoSysPro.Units.SI.SpecificHeatCapacity uo2_cp "Intermediary cp (UO2)";
  ThermoSysPro.Units.SI.SpecificHeatCapacity puo2_cp "Intermediary cp (PuO2)";
  Real T_C "Fuel Temperature in °C";
  Real p_coef "Porosity Coefficient";
equation

  T_C = T - 273.15;

  uo2_cp = 296.7*535.285^2*exp(535.285/T)/(T^2*(exp(535.285/T)-1)^2)+2.43e-2*T+oxy_on_metal/2*8.745e7*1.577e5/(8.3143*T^2)*exp(-1.577e5/(8.3143*T));

  //Matpro correlations
  if MOX then
    p_coef = 1.43;
    k = 100 * (max(33.0/(375+T_C),0.0171)+1.540e-4*exp(1.710e-3*T_C)) * (1-p_coef*porosity)/(1-p_coef*0.04)*(1-porosity)/0.96;
    puo2_cp = 347.4*571.000^2*exp(571.000/T)/(T^2*(exp(571.000/T)-1)^2)+3.95e-2*T+oxy_on_metal/2*3.86e7*1.967e5/(8.3143*T^2)*exp(-1.967e5/(8.3143*T));
    cp = puo2_cp*pu_mFraction + uo2_cp*(1-pu_mFraction);
  else
    p_coef = 2.58 - 0.58e-3*T_C;
    k = 100 * (max(40.4/(464+T_C),0.0191)+1.216e-4*exp(1.867e-3*T_C)) * (1-p_coef*porosity)/(1-p_coef*0.05);
    cp = uo2_cp;
    puo2_cp = 375; //Not used
  end if;

  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)),
    Documentation(info="# Property Model for Nuclear Fuel Material
Correlations are taken from:
1. N.E. Todreas, M. S. Kazimi, Nuclear System I, Thermal Hydraulics Fundamentals. Taylor&Francis, 1798.
2. MATPRO VERSION 11, A HANDBOOK OF MATERIALS PROPERTIES FOR USE IN THE ANALYSIS OF LIGHT WATER REACTOR FUEL ROD BEHAVIOR. NUREG/CR-0497 TREE-1280, 1979.

They apply for both \\\\(UO_2\\\\) and \\\\(MOX\\\\) fuels. The effect of porosity is taken into account. However, other effects such as burnup or others still need to be taken into account.
"));
end FuelProperties;
