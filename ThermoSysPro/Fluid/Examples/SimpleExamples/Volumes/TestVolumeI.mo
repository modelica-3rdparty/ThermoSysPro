within ;
model TestVolumeI
  extends ThermoSysPro.UsersGuide.Icons.Example;

  replaceable package Medium = ThermoSysPro.Properties.Media.WaterSteam;
  ThermoSysPro.Fluid.BoundaryConditions.Sink sink(redeclare replaceable package
      Medium =                                                                           Medium) annotation (Placement(transformation(extent={{30,-10},{50,10}})));
  VolumeI                            volumeI(redeclare package Medium = Medium) annotation (Placement(transformation(extent={{-10,-10},{10,10}})));
  ThermoSysPro.Fluid.BoundaryConditions.SourcePQ sourcePQ(
                                                        redeclare replaceable
      package Medium =                                                                         Medium) annotation (Placement(transformation(extent={{-52,-10},
            {-32,10}})));
  SinkQ                                      sinkQ(redeclare replaceable
      package Medium = Medium)                                                                   annotation (Placement(transformation(extent={{12,22},
            {32,42}})));
  ThermoSysPro.Fluid.BoundaryConditions.SourceQ sourceQ(redeclare replaceable
      package Medium = Medium)                                                                         annotation (Placement(transformation(extent={{-50,10},
            {-30,30}})));
equation
  connect(volumeI.Cs3, sink.C)
    annotation (Line(points={{10,-8},{20,-8},{20,0},{30,0}}, color={0,0,0}));
  connect(volumeI.Cs1, sinkQ.C)
    annotation (Line(points={{10,8},{10,32},{12,32}}, color={0,0,0}));
  connect(sourcePQ.C, volumeI.Ce2)
    annotation (Line(points={{-32,0},{-10,0}}, color={0,0,0}));
  connect(sourceQ.C, volumeI.Ce1)
    annotation (Line(points={{-30,20},{-10,20},{-10,8}}, color={0,0,0}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(coordinateSystem(preserveAspectRatio=false)),
    uses(ThermoSysPro(version="5.0")));
end TestVolumeI;
