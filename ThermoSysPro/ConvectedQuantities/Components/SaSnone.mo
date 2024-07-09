within ThermoSysPro.ConvectedQuantities.Components;
model SaSnone
  extends partialSaS;


equation

    SatRes = fill(1,size(SubC,1));
    C = fill(0,size(SubC,1));



end SaSnone;
