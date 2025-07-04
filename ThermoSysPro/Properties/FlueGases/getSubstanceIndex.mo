within ThermoSysPro.Properties.FlueGases;
function getSubstanceIndex
  input String substanceName;
  input String substanceNames[:];
  output Integer index;
algorithm
  index := 0;
  for i in 1:size(substanceNames, 1) loop
    if substanceNames[i] == substanceName then
      index := i;
      return;
    end if;
  end for;
  assert(false, "Substance name " + substanceName + " not found in the list.");

end getSubstanceIndex;
