within ThermoSysPro.Fluid.Examples.SimpleExamples.HeatExchangers;
model TestDynamicMultiFluidHeatExchangerShell_FlueGases
  extends TestDynamicMultiFluidHeatExchangerShell(
    redeclare package Medium_shell = Properties.Media.FlueGases,
    redeclare package Medium_pipe = Properties.Media.FlueGases,
    exchanger(P0=450000, h0=fill(3e6, 1), option_temperature=false),
    sourceShell(P0=450000, h0=3e6, option_temperature=false, X0={0.1,0.2,0.3,0.2,0.2}),
    sinkShell(P0=100000, h0=3e6, option_temperature=false),
    sourcePipe(P0=450000, h0=3e6, option_temperature=false, X0={0.1,0.2,0.3,0.2,0.2}),
    sinkPipe(P0=100000, h0=3e6, option_temperature=false));
end TestDynamicMultiFluidHeatExchangerShell_FlueGases;
