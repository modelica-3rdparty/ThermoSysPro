within ThermoSysPro.Fluid.Examples.SimpleExamples.PressureLosses;
model TestLumpedStraightPipe_Traces
  extends ThermoSysPro.UsersGuide.Icons.Example;

  replaceable package Medium = Properties.Media.WaterSteam(extraPropertiesNames={"Trace"}, C_nominal={0.1}, C_default={0.2});

  ThermoSysPro.Fluid.BoundaryConditions.SourcePQ sourcePQ(redeclare
      replaceable package Medium = Medium,  SubC0={0.3})                                                               annotation (Placement(transformation(extent={{-52,-10},
            {-32,10}})));
  ThermoSysPro.Fluid.BoundaryConditions.Sink sink(redeclare replaceable package
      Medium = Medium)                                                                           annotation (Placement(transformation(extent={{28,-10},
            {48,10}})));
  ThermoSysPro.Fluid.PressureLosses.LumpedStraightPipe lumpedStraightPipe(redeclare
      replaceable package Medium =
               Medium)
    annotation (Placement(transformation(extent={{-10,-10},{10,10}})));
equation
  connect(sourcePQ.C, lumpedStraightPipe.C1)
    annotation (Line(points={{-32,0},{-10,0}}, color={0,0,0}));
  connect(sink.C, lumpedStraightPipe.C2)
    annotation (Line(points={{28,0},{10,0}}, color={0,0,0}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)));
end TestLumpedStraightPipe_Traces;
