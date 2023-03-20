within ThermoSysPro.Fluid.Examples.SimpleExamples;
model TestConvectedQuantities_LiquidoPhile

  replaceable package Species =
      ThermoSysPro.ConvectedQuantities.Substances.LiquidoPhile
  annotation(choicesAllMatching = true, Dialog(tab="Fluid", group="Transported Substances"));

  import C =  ThermoSysPro.ConvectedQuantities.Substances.LiquidoPhile.Concentrations;

  Real substances_out_gas[C];
  Real substances_out_liq[C];
  Real substances_in[C];

  parameter Real start_title = 0.7 "";
  parameter ThermoSysPro.Units.SI.SpecificEnthalpy start_h(fixed=false,start=2.e6) "";

  ThermoSysPro.Fluid.BoundaryConditions.SourcePQ sourcePQ(
    redeclare package Species = Species,
    Cin={0.5},
    T0=473.15,
    h0=1.e6,
    C(h(start=2.e6)))
    annotation (Placement(transformation(extent={{-158,-16},{-126,16}})));
  ThermoSysPro.Fluid.BoundaryConditions.Sink sink_gas(redeclare package Species =
        Species)
    annotation (Placement(transformation(extent={{-2,-10},{18,10}})));
  ThermoSysPro.Fluid.PressureLosses.PipePressureLoss pipePressureLoss(redeclare
      package Species = Species, Pm(start=
          277250.29682728346))
    annotation (Placement(transformation(extent={{-110,-10},{-90,10}})));
  ThermoSysPro.Fluid.Junctions.SteamDryer steamDryer(
    redeclare package Species = Species,
    h(start=2.e6),
    xe(fixed=true, start=start_title),
    Cev(h(start=2.e6)))
    annotation (Placement(transformation(extent={{-48,-14},{-28,6}})));
  ThermoSysPro.Fluid.BoundaryConditions.Sink sink_liq(redeclare package Species =
        Species)
    annotation (Placement(transformation(extent={{-10,-36},{10,-16}})));
  ThermoSysPro.InstrumentationAndControl.Blocks.Sources.Rampe enthalpy_ramp(
    Duration=100,
    Initialvalue=start_h,
    Finalvalue=2.5e6)
    annotation (Placement(transformation(extent={{-178,-28},{-158,-8}})));
  ThermoSysPro.Fluid.Volumes.VolumeA volumeA(redeclare package Species =
        Species, h(start=
          2063483.7532614567))
    annotation (Placement(transformation(extent={{-82,-10},{-62,10}})));
equation
  substances_in = steamDryer.Cev.SubC * steamDryer.Cev.Q;
  substances_out_gas = steamDryer.Csv.SubC * steamDryer.Csv.Q;
  substances_out_liq = steamDryer.Csl.SubC * steamDryer.Csl.Q;

  connect(sourcePQ.C, pipePressureLoss.C1)
    annotation (Line(points={{-126,0},{-110,0}}, color={0,0,0}));
  connect(sourcePQ.ISpecificEnthalpyOrTemperature, enthalpy_ramp.y) annotation (
     Line(points={{-142,-8},{-150,-8},{-150,-18},{-157,-18}}, color={0,0,255}));
  connect(pipePressureLoss.C2, volumeA.Ce1)
    annotation (Line(points={{-90,0},{-82,0}}, color={0,0,0}));
  connect(volumeA.Cs1, steamDryer.Cev)
    annotation (Line(points={{-62,0},{-47.9,0}}, color={0,0,0}));
  connect(steamDryer.Csv, sink_gas.C)
    annotation (Line(points={{-28.1,0},{-2,0}}, color={0,0,0}));
  connect(steamDryer.Csl, sink_liq.C) annotation (Line(points={{-37.9,-14},{-38,
          -14},{-38,-26},{-10,-26}}, color={0,0,0}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false, extent={{-180,
            -60},{20,40}})), Diagram(coordinateSystem(preserveAspectRatio=false,
          extent={{-180,-60},{20,40}})),
    experiment(StopTime=120, __Dymola_Algorithm="Dassl"));
end TestConvectedQuantities_LiquidoPhile;
