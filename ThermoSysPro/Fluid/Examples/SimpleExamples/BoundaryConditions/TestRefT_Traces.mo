within ThermoSysPro.Fluid.Examples.SimpleExamples.BoundaryConditions;
model TestRefT_Traces
  extends ThermoSysPro.UsersGuide.Icons.Example;

  replaceable package Medium = Properties.Media.WaterSteam(extraPropertiesNames={"Trace1", "Trace2", "Trace3"}, C_nominal={0.1, 0.2, 0.3}, C_default={0.2, 0.3, 0.4});

  ThermoSysPro.Fluid.BoundaryConditions.Sink sink(redeclare replaceable package
                                                                                Medium =
        Medium)
    annotation (Placement(transformation(extent={{66,-10},{86,10}})));
  ThermoSysPro.Fluid.PressureLosses.PipePressureLoss pipePressureLoss(
      redeclare replaceable package Medium = Medium)
    annotation (Placement(transformation(extent={{32,-10},{52,10}})));
  ThermoSysPro.Fluid.BoundaryConditions.RefT refT(redeclare replaceable package
                                                                                Medium =
        Medium)
    annotation (Placement(transformation(extent={{-10,-10},{10,10}})));
  ThermoSysPro.Fluid.BoundaryConditions.SourceQ sourceQ(redeclare replaceable
      package
      Medium = Medium, h0=2600e3, SubC0={10,20,30})
    annotation (Placement(transformation(extent={{-66,-10},{-46,10}})));
  InstrumentationAndControl.Blocks.Sources.Constante constante(k=120 + 273.15)
    annotation (Placement(transformation(extent={{-30,38},{-10,58}})));
equation
  connect(sink.C, pipePressureLoss.C2)
    annotation (Line(points={{66,0},{52,0}}, color={0,0,0}));
  connect(refT.C2, pipePressureLoss.C1)
    annotation (Line(points={{10,0},{32,0}}, color={0,0,0}));
  connect(sourceQ.C, refT.C1)
    annotation (Line(points={{-46,0},{-10,0}}, color={0,0,0}));
  connect(constante.y, refT.ITemperature)
    annotation (Line(points={{-9,48},{0,48},{0,11}}, color={0,0,255}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)));
end TestRefT_Traces;
