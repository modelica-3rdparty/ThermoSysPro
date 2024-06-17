within ThermoSysPro.ConvectedQuantities;
package Sink_and_Source
  package None

  //replaceable package Species = Substances.None;

  replaceable block SaS_None

    import      ThermoSysPro.Units.SI;

    //parameter Integer vsize;

    //input Real SubC[Species.Concentrations] "Total Species Concentrations";
    input Real SubC[:] "Total Species Concentrations";

    input SI.Temperature T "Température";
    input SI.MassFlowRate Q "Débit";
    input Real capa "Capacité totale de la résine";
    input SI.Area S "Surface de la résine";

    input SI.Density rho_liquidPhase "Liquid Phase Density";
    input Real x "Title";
    parameter Integer choix_resine;

  //   output SI.Velocity v[Species.Concentrations]
  //     "Vitesse du front dans la résine";
  //   output Real C[Species.Concentrations];


    //output SI.Velocity v[size(SubC,1)]
      // "Vitesse du front dans la résine";

    output Real SatRes[size(SubC,1)];
    output Real C[size(SubC,1)];

    parameter SI.Length D=1;
    parameter SI.Length L=1;

  equation
      //v = fill(0,size(SubC,1));
      SatRes = fill(1,size(SubC,1));
      C = fill(0,size(SubC,1));

    annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
          coordinateSystem(preserveAspectRatio=false)));
  end SaS_None;

  end None;

  package degradation
    extends ThermoSysPro.ConvectedQuantities.Sink_and_Source.None(redeclare
        block
        SaS_None = SaS_degradation);

  block SaS_degradation

    import      ThermoSysPro.Units.SI;

    //parameter Integer vsize;


    //input Real SubC[vsize] "Total Species Concentrations";
    input Real SubC[:] "Total Species Concentrations";

    input SI.Temperature T "Température";
    input SI.MassFlowRate Q "Débit";
    input Real capa "Capacité totale de la résine";
    input SI.Area S "Surface de la résine";

    input SI.Density rho_liquidPhase "Liquid Phase Density";
    input Real x "Title";
    parameter Integer choix_resine;




  //   output SI.Velocity v[vsize]
  //     "Vitesse du front dans la résine";
  //   output Real C[vsize](start=ones(size(SubC, 1)))
  //     "Species Concentration after degradation";

    //output SI.Velocity v[size(SubC, 1)]
      //"Vitesse du front dans la résine";
    output Real SatRes[size(SubC, 1)];
    output Real C[size(SubC, 1)](start=ones(size(SubC, 1)))
      "Species Concentration after degradation";

    parameter SI.Length D=1;
    parameter SI.Length L=1;

  equation

    C = SubC * 0.8;
    //v = fill(0,size(SubC,1));
    SatRes = fill(1,size(SubC,1));




   annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
          coordinateSystem(preserveAspectRatio=false)));
  end SaS_degradation;
  end degradation;
end Sink_and_Source;
