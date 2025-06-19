within ;
model TestVolumeD_Traces
  extends ThermoSysPro.UsersGuide.Icons.Example;

  replaceable package Medium = ThermoSysPro.Properties.Media.WaterSteam (
      extraPropertiesNames={"Trace"},
      C_nominal={0.1},
      C_default={0.2});
  ThermoSysPro.Fluid.BoundaryConditions.Sink sink(redeclare replaceable package
      Medium =                                                                           Medium) annotation (Placement(transformation(extent={{20,20},
            {40,40}})));
  ThermoSysPro.Fluid.BoundaryConditions.SourcePQ sourcePQ(redeclare
      replaceable package Medium =                                                               Medium,
    Q0=100,
    SubC0={0.5})                                                                                         annotation (Placement(transformation(extent={{-50,-10},{-30,10}})));
  VolumeD                            volumeD(redeclare package Medium = Medium,
    V=1,
    dynamic_mass_balance=false)                                                 annotation (Placement(transformation(extent={{-12,-10},
            {8,10}})));
  SinkQ                                         sinkQ(  redeclare replaceable
      package Medium =                                                                         Medium) annotation (Placement(transformation(extent={{-10,-10},
            {10,10}},
        rotation=0,
        origin={40,0})));
equation
  connect(volumeD.Cs1, sink.C)
    annotation (Line(points={{-2,10},{-2,30},{20,30}},
                                             color={0,0,0}));
  connect(sourcePQ.C, volumeD.Ce)
    annotation (Line(points={{-30,0},{-12,0}}, color={0,0,0}));
  connect(volumeD.Cs3, sinkQ.C)
    annotation (Line(points={{8,0},{30,0}}, color={0,0,0}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(coordinateSystem(preserveAspectRatio=false)),
    uses(ThermoSysPro(version="5.0")));
end TestVolumeD_Traces;
