within ThermoSysPro.Fluid.Examples.SimpleExamples.BoundaryConditions;
model TestRefT
  extends ThermoSysPro.UsersGuide.Icons.Example;

  replaceable package Medium = Properties.Media.WaterSteam;


  ThermoSysPro.Fluid.BoundaryConditions.Sink sink(redeclare package Medium =
        Medium)
    annotation (Placement(transformation(extent={{66,-10},{86,10}})));
  ThermoSysPro.Fluid.PressureLosses.PipePressureLoss pipePressureLoss(
      redeclare package Medium = Medium)
    annotation (Placement(transformation(extent={{32,-10},{52,10}})));
  ThermoSysPro.Fluid.BoundaryConditions.RefT refT(redeclare package Medium =
        Medium)
    annotation (Placement(transformation(extent={{-10,-10},{10,10}})));
  ThermoSysPro.Fluid.BoundaryConditions.SourceQ sourceQ(redeclare package
      Medium = Medium, h0=2600e3)
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
end TestRefT;
