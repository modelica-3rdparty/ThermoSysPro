import re
import os
import sympy as sp


current_dir = os.path.dirname(os.path.realpath(__file__))
where_TSP = os.path.join(current_dir, "ThermoSysPro")


def extract_variable_names(text, pattern):
    matches = re.findall(pattern, text)
    return [match for match in matches]
    
def process_constant(function_name,output_name_noSpecialChar,input_variables,arguments,output_name,output_variables):
    output_comp = function_name + " " + output_name_noSpecialChar+"_calc("
    for i in range(len(input_variables)-1):
        output_comp += input_variables[i] + " = "+arguments[i]+", "
    output_comp += input_variables[-1]+" = "+arguments[-1]+");"
    # output_comps.append(output_comp)

    output_equation = output_name + " = " + output_name_noSpecialChar+"_calc."+output_variables+";"
    # output_equations.append(output_equation)
    return [output_comp],[output_equation]
    
def process_withbrackets(m,forLooplist,function_name,input_variables,arguments,output_name,output_variables,name_beforeCalc):
    print("matches:", m)
    arguments_copy=arguments.copy()
    iter_var_from_match = m[1]
    print("iter_var_from_match:",iter_var_from_match)
    if forLooplist: #check not empty
        for dict_loop in forLooplist:
            if dict_loop['variable'] in iter_var_from_match:
                output_comp = function_name + " " +name_beforeCalc+"_calc["+sympify_eq(dict_loop['end']+"-"+dict_loop['start']+"+1")+"]("
                for i in range(len(input_variables)):
                    if re.findall(r'\[(.*?'+dict_loop['variable']+'.*?)\]', arguments_copy[i]):
                        # if bracket with dict_loop['variable'] inside it (for instance P[i + 1]), then it should be a vector # trop permittif (car fonctionne même si iter_var_from_match pas dedans) :"[" in arguments[i] or "]" in arguments[i]:
                        arguments_copy[i] = re.sub(r'\[(.*?)\]', lambda match: "["+sympify_eq(str((match.group(1)).replace(dict_loop['variable'], dict_loop['start'])))+":"+sympify_eq(str(((match.group(1)).replace(dict_loop['variable'], dict_loop['end']))))+"]", arguments[i])
                        output_comp += input_variables[i] + " = "+arguments_copy[i]
                    else:
                        # inside a for loop with iter_var_from_match (for instance pro1[i]), but this argument does not used iter_var_from_match : each must be used for the definition
                        output_comp += "each " + input_variables[i] + " = "+arguments_copy[i]
                    if i < len(input_variables)-1:
                        output_comp += ", "
                    else:
                        output_comp += ");"
                output_equation = output_name + " = " + name_beforeCalc+"_calc["+sympify_eq(iter_var_from_match+"-"+dict_loop['start']+"+1")+"]." + output_variables+";"
                return [output_comp],[output_equation]
            else:
                raise ("iter_var_from_match not found in for loops of forLooplist")
    else:
        #not in a for loop thus constant
        print("HERE CONSTANT ?")
        suffix="".join(["_" if (x=='+'or x=='-') else x for x in m[1].replace(" ","")]) #because if m[1]="N+1", + would have been in the name (to test try suffix=m[1] and rhoc[N + 1] = ThermoSysPro.Properties.Fluid.Density_Ph((P[N + 1]), h[N + 1], fluid, mode, Xco2, Xh2o, Xo2, Xso2);")
        [output_comp],[output_equation]=process_constant(function_name,m[0]+suffix,input_variables,arguments,output_name,output_variables)
        return [output_comp],[output_equation]
    
def string_to_list(s):
    # Vérifier si la chaîne commence par '(' et se termine par ')'
    if s.startswith('(') and s.endswith(')'):
        # Supprimer les parenthèses du début et de la fin de la chaîne
        s = s.strip('()')

        # Diviser la chaîne en fonction des virgules pour obtenir les éléments individuels
        elements = s.split(',')

        # Enlever les espaces blancs autour de chaque élément
        elements = [elem.strip() for elem in elements]

        return elements
    else:
        # Si ce n'est pas un tuple, ne rien faire (ou gérer selon le besoin)
        return None
        
def sympify_eq(expression):
    # https://stackoverflow.com/questions/31653972/parsing-an-expression-containing-n-using-sympy
    forbidden_sympy_list = ["I", "E", "S", "N", "C", "O", "Q"]
    forbidden_used = []
    for sym in forbidden_sympy_list:
        if sym in expression:
            expression = expression.replace(sym, sym+"_symb")
            forbidden_used.append(sym)
    simplified_result = (str(sp.sympify(expression)))
    for sym in forbidden_used:
        simplified_result = simplified_result.replace(sym+"_symb", sym)
    return simplified_result

def whereToWriteComponents(dict_code):
    list_keys=list(dict_code.keys())
    if "whereToWriteComponents" not in list_keys:
        if dict_code["protected"]!=None :
            if dict_code["public"]!=None and dict_code["protected"]>dict_code["public"]:
                dict_code["whereToWriteComponents"]=dict_code["protected"]-1
            else:
                dict_code["whereToWriteComponents"]=min([item for item in [dict_code["initial equation"],dict_code["equation"],dict_code["initial algorithm"],dict_code["algorithm"]] if item is not None])
        else:
            dict_code["whereToWriteComponents"]=min([item for item in [dict_code["initial equation"],dict_code["equation"],dict_code["initial algorithm"],dict_code["algorithm"]] if item is not None])
    return dict_code

def does_start_with(character,line):
    return line.lstrip().startswith(character)
    
def get_spaces_before_1stCharacter(string):
    cha=''
    for i in range(len(string)):
        if string[i]==' ':
            cha+=string[i]
        if string[i]!=' ':
            return cha
    return cha  
    
def process_input(input_string,make_changes=False,path_to_write="modified_component.mo"):
    lines = input_string.strip().split('\n')
    comp_def_model = [] #comp which will be instantiated
    if make_changes==True:
        comment_new=""
        comment_old="// "
    else:
        comment_new="// "
        comment_old=""

    forLooplist = []
    dict_code={}
    keyList = ["initial equation", "equation", "initial algorithm", "algorithm", "protected", "public"]
    # iterating through the elements of list
    for i in keyList:
        dict_code[i] = None
    tobeWritten=[]
    for line_number in range(len(lines)):
        output_equations = []
        output_comps = []
        line = lines[line_number]
        tobeWritten.append(line)
        
        if does_start_with('public',line):
            dict_code['public']=line_number
        elif does_start_with('protected',line):
            dict_code['protected']=line_number
        elif does_start_with('initial equation',line):
            dict_code['initial equation']=line_number
            dict_code=whereToWriteComponents(dict_code)
        elif does_start_with('equation',line):
            dict_code['equation']=line_number
            dict_code=whereToWriteComponents(dict_code)
        elif does_start_with('initial algorithm',line):
            dict_code['initial algorithm']=line_number
            dict_code=whereToWriteComponents(dict_code)
        elif does_start_with('algorithm',line):
            dict_code['algorithm']=line_number
            dict_code=whereToWriteComponents(dict_code)
        
        if does_start_with('//',line): 
            1==1 #do nothing
        elif "for" in line and "in" in line and "loop" in line:  # In for loop
            match_forLoop = re.search(
                r'for\s+(\w+)\s+in\s+(.+)\s*:\s*(.+)\s+loop', line)
            if match_forLoop:
                variable = match_forLoop.group(1)
                start = match_forLoop.group(2)
                end = match_forLoop.group(3)
                forLooplist.append(
                    {'variable': variable, 'start': start, 'end': end})

        elif "end for" in line:  # Out for loop
            forLooplist.pop()

        elif "Properties.Fluid" in line:  # Line to be changed
            output_lines = []
            # Utilisation d'une regex pour extraire la partie avant '='
            match_outputName = re.search(r'^(.*?)\s*=', line)

            # Utilisation d'une regex pour extraire la partie entre '=' et '('
            match_functionName = re.search(r'=\s*([^(\s]+)\s*\((.*)\)', line)
            if match_functionName:
                output_name = match_outputName.group(1).replace(" ","")
                
                function_name = match_functionName.group(1)
                arguments_str = match_functionName.group(2)

                # Construire le chemin du fichier .mo
                mo_file_path = os.path.join(
                    where_TSP, function_name.replace('.', '/') + '.mo') 
                print("Properties.Fluid function:", mo_file_path)

                # Séparer les arguments en une liste
                arguments = [arg.strip() for arg in arguments_str.split(',')]

                # Vérifier si le fichier .mo existe et le lire
                if os.path.exists(mo_file_path):
                    with open(mo_file_path, 'r') as f:
                        mo_content = f.read()

                        # Regex pour trouver les lignes avec input et extraire le troisième mot
                        pattern_input = r"input\s+\S+\s+(\S+)"
                        # Regex pour trouver les lignes avec output et extraire le troisième mot
                        pattern_output = r"output\s+\S+\s+(\S+)"

                        input_variables = extract_variable_names(
                            mo_content, pattern_input)
                        output_variables = extract_variable_names(
                            mo_content, pattern_output)
                        print("input_variables:", input_variables)
                        print("output_variables:", output_variables)
                        print("arguments:", arguments)
                        
                        

                        if (len(input_variables) != len(arguments)):
                            raise ("Error")

                else:
                    output_lines.append(f"Fichier {mo_file_path} non trouvé.")
                
                match_Brackets_letters = re.findall(r"([a-zA-Z_][a-zA-Z0-9_]*)\[(.*?)\]", output_name)
                match_tuples = re.findall(r"\((.*?),(.*?)\)", output_name)
                tuple_verification=(output_name.replace(' ','').startswith('('))
                print("output_name:", output_name)
                print("match_Brackets_letters:",match_Brackets_letters)
                print("function_name:", function_name)
                print("output_name:", output_name)
                print("output_variables:", output_variables)
                print("match_tuples:",match_tuples)
                
                # pro1[i] = ThermoSysPro.Properties.Fluid.Ph(P[i + 1], h[i + 1], mode, fluid);
                if tuple_verification:
                    # print("match_Brackets_letters:",match_Brackets_letters)
                    # print("function_name:", function_name)
                    # print("output_name:", output_name)
                    # print("output_variables:", output_variables)
                    # print("match_tuples:",match_tuples)
                    list_inTubles=output_name.replace('(','').replace(')','').replace(' ','').split(',')    #I can't make a good regex for comma separated thus with replace and split
                    # print("list_inTuples:",list_inTubles)
                    
                    function_name_tuple=""
                    for elementinTuple in list_inTubles:
                        function_name_tuple+=(elementinTuple.split('['))[0]
                        
                    if match_Brackets_letters:
                        for j in range(len(match_Brackets_letters)):
                            m=match_Brackets_letters[j]
                            # print("output_name=",output_name)
                            comp_def_model.append(function_name_tuple+"_calc")
                            [output_comp],[output_equation]=process_withbrackets(m,forLooplist,function_name,input_variables,arguments,list_inTubles[j],output_variables[j],name_beforeCalc=function_name_tuple)
                            if j==0:
                                output_comps.append(output_comp)    
                            output_equations.append(output_equation)
                    else:
                        for i in range(len(list_inTubles)):
                            comp_def_model.append(function_name_tuple+"_calc")
                            [output_comp],[output_equation]=process_constant(function_name,function_name_tuple,input_variables,arguments,list_inTubles[i],output_variables[i])
                            if i==0:
                                output_comps.append(output_comp)    
                            output_equations.append(output_equation)
                    
                    
                elif match_Brackets_letters:
                    if len(match_Brackets_letters) > 1:
                        raise("MULTIPLE MATCHES WITH BRACKETS")
                        
                    else:
                        m = match_Brackets_letters[0]
                        print("m:",m)
                        print("output_variables:",output_variables)
                        name_beforeCalc=m[0]
                        if name_beforeCalc+"_calc" in comp_def_model:
                            name_beforeCalc+="_"
                        comp_def_model.append(name_beforeCalc+"_calc")
                        [output_comp],[output_equation]=process_withbrackets(m,forLooplist,function_name,input_variables,arguments,output_name,output_variables[0],name_beforeCalc=name_beforeCalc)
                        output_comps.append(output_comp)    
                        output_equations.append(output_equation)
                else:
                    output_name_noSpecial=re.sub(r'[^a-zA-Z\d\s]','_',output_name)    #Replace every nonalphanumerical charac by '_' so that it can be written in a variable
                    if output_name_noSpecial+"_calc" in comp_def_model:
                        output_name_noSpecial+="_"
                    comp_def_model.append(output_name_noSpecial+"_calc")
                    [output_comp],[output_equation]=process_constant(function_name,output_name_noSpecial,input_variables,arguments,output_name,output_variables[0])                        
                    output_comps.append(output_comp)    
                    output_equations.append(output_equation)

                print("output_equation:", output_equation)
                print("output_comp:", output_comp)
                print("\n")
            tobeWritten.pop()
            tobeWritten.append(comment_old+line+"// Commented automatically, to be verified MAZU")
            for comp in output_comps:
                if 'whereToWriteComponents' not in list(dict_code.keys()):
                    dict_code['whereToWriteComponents']=0
                # tobeWritten.insert(dict_code['whereToWriteComponents'],get_spaces_before_1stCharacter(lines[dict_code['whereToWriteComponents']-1])+comment_new+comp+"// To be verified MAZU")
                tobeWritten.insert(dict_code['whereToWriteComponents'],'  '+comment_new+comp+"// To be verified MAZU")
                dict_code["whereToWriteComponents"]+=1
                # print(comp)
            # print("\n")
            for equa in output_equations:
                
                tobeWritten.append(get_spaces_before_1stCharacter(lines[line_number])+comment_new+equa+"// To be verified MAZU")
                # print(equa)
            
    # print("tobeWritten:",tobeWritten)
    # print("dict_code:",dict_code)
    folder_path_to_write=os.path.dirname(path_to_write)
    if not os.path.exists(folder_path_to_write):
        os.makedirs(folder_path_to_write)
    with open(path_to_write, 'w+') as f:
        for line in tobeWritten:
            f.write(f"{line}\n")
    return


# # Exemple d'utilisation
input_string = """
model abc
parameter Real a=5;
public
Real T;
protected
Real pi;
equation
rho=ThermoSysPro.Properties.Fluid.Density_Ph(C1.P, h, fluid, mode, C1.Xco2,  C1.Xh2o,  C1.Xo2, C1.Xso2)

for i in 2:N loop
  h[i] = ThermoSysPro.Properties.Fluid.SpecificEnthalpy_PT(Pb[i], T0[i - 1], fluid, mode, Xco2, Xh2o, Xo2, Xso2);
end for;
"""

input_string="""
model abc
parameter Real a=5;
public
Real T;
protected
Real pi;
equation
if (exchanger_type == 2) then
   Tsf = ThermoSysPro.Properties.Fluid.Temperature_Ph(Sc.P, Sc.h, fluid_c, mode_c,  Ec.Xco2, Ec.Xh2o, Ec.Xo2, Ec.Xso2);// Commented automatically, to be verified MAZU
  elseif (exchanger_type == 3) then
   Tsf = ThermoSysPro.Properties.Fluid.Temperature_Ph(Sf.P, Sf.h, fluid_f, mode_f,  Ef.Xco2, Ef.Xh2o, Ef.Xo2, Ef.Xso2);// Commented automatically, to be verified MAZU
  end if;
(lsat1,vsat1) = ThermoSysPro.Properties.Fluid.Water_sat_P(P[1], fluid);
"""

if __name__=='__main__':
    # while True:
    #     input_string=input(r"Veuillez entrer le texte à traiter : ")
    #     process_input(input_string)
    output = process_input(input_string,make_changes=True ,path_to_write=current_dir+'/towrite.txt')
