within ThermoSysPro.Fluid.Examples.SimpleExamples.HeatExchangers;
model TestDynamicMultiFluidHeatExchanger_FlueGases
  extends TestDynamicMultiFluidHeatExchanger(
    redeclare package Medium_1 = Properties.Media.FlueGases,
    redeclare package Medium_2 = Properties.Media.FlueGases,
    exchanger(P0=450000, h0=fill(3e6, 1), option_temperature=false),
    source1(P0=450000, h0=3e6, option_temperature=false, X0={0.1,0.2,0.3,0.2,0.2}),
    sink1(P0=100000, h0=3e6, option_temperature=false),
    source2(P0=450000, h0=3e6, option_temperature=false, X0={0.1,0.2,0.3,0.2,0.2}),
    sink2(P0=100000, h0=3e6, option_temperature=false));
end TestDynamicMultiFluidHeatExchanger_FlueGases;
