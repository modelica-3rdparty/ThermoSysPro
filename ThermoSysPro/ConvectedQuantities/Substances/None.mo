within ThermoSysPro.ConvectedQuantities.Substances;
package None
  replaceable type Concentrations = enumeration(:);
  replaceable block PhasesSeparation
    import      ThermoSysPro.Units.SI;

    input SI.Temperature T "Fluid Temperature";
    input SI.Density rho_liquidPhase "Fluid Density";
    input Real x "Title";
    input Real SubC[None.Concentrations] "Total Species Concentrations";

    output Real Cl[None.Concentrations] "Species Concentration in the Liquid Phase";
    output Real Cg[None.Concentrations] "Species Concentration in the Gas Phase";

  equation
    Cl = fill(0,size(Cl,1));
    Cg = fill(0,size(Cl,1));

    annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
          coordinateSystem(preserveAspectRatio=false)));
  end PhasesSeparation;

  replaceable block pH

    import      ThermoSysPro.Units.SI;

    input SI.Temperature T "Fluid Temperature";
    input SI.Density rho_liquidPhase "Fluid Density";
    input Real x "Title";
    input Real SubC[None.Concentrations] "Total Species Concentrations";

    output Real pH "";

    Real OHm(start=1.e-7) "";
    Real Kw "";
    Real rel_density "Relative density compared to 25 °C";

  equation

    //Density as ratio of water dentity @ T and water density @ 25°C
    rel_density = rho_liquidPhase / 999.975;

    Kw=10^(-4.098+(-3245.2/T)+((2.2362e5/(T*T)))+((-3.984e7)/(T*T*T))+((13.957+(-1262.3/T)+((8.564e5)/(T*T)))*log10(rel_density)));

    OHm = Kw^(1/2);
    OHm = 10^(pH+log10(Kw));

    annotation (Icon(coordinateSystem(preserveAspectRatio=false), graphics={
                                            Ellipse(
            extent={{-60,60},{60,-60}},
            lineColor={0,0,255},
            fillColor={28,108,200},
            fillPattern=FillPattern.Solid),
          Polygon(
            points={{60,0},{58,14},{54,26},{48,36},{38,46},{26,54},{14,58},{0,60},
                {0,0},{60,0}},
            fillColor={170,255,255},
            fillPattern=FillPattern.Solid,
            pattern=LinePattern.None),
          Polygon(
            points={{-60,0},{-58,14},{-54,26},{-48,36},{-38,46},{-26,54},{-14,58},
                {0,60},{0,0},{-60,0}},
            fillColor={170,255,255},
            fillPattern=FillPattern.Solid,
            pattern=LinePattern.None),
          Ellipse(
            extent={{-42,28},{-26,12}},
            lineColor={28,108,200},
            fillColor={28,108,200},
            fillPattern=FillPattern.Solid),
          Ellipse(
            extent={{-18,48},{-6,36}},
            lineColor={28,108,200},
            fillColor={28,108,200},
            fillPattern=FillPattern.Solid),
          Ellipse(
            extent={{-4,24},{16,4}},
            lineColor={28,108,200},
            fillColor={28,108,200},
            fillPattern=FillPattern.Solid),
          Ellipse(
            extent={{26,34},{42,18}},
            lineColor={28,108,200},
            fillColor={28,108,200},
            fillPattern=FillPattern.Solid),
          Ellipse(
            extent={{24,-12},{40,-28}},
            lineColor={28,108,200},
            fillColor={85,255,255},
            fillPattern=FillPattern.Solid),
          Ellipse(
            extent={{-40,-22},{-24,-38}},
            lineColor={28,108,200},
            fillColor={85,255,255},
            fillPattern=FillPattern.Solid),
          Ellipse(
            extent={{10,-36},{22,-48}},
            lineColor={28,108,200},
            fillColor={85,255,255},
            fillPattern=FillPattern.Solid),
          Ellipse(
            extent={{-20,-4},{2,-26}},
            lineColor={28,108,200},
            fillColor={85,255,255},
            fillPattern=FillPattern.Solid)}), Diagram(coordinateSystem(
            preserveAspectRatio=false)));
  end pH;





end None;
