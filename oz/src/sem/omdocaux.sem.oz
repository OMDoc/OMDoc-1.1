%%
%% parser semantics for omdoc auxiliuary items
%%
      
meth 'make_exercise'(E $)
   (Metadata#Symbols#CMPs#FMP)#Hint#SolMCs = E.content
   R = case E.model.3
       of list('*' 'solution') then
          unit(solutions: SolMCs
               model: solutions)
       [] list('*' 'mc') then
          unit(mcs: SolMCs
               model: mcs)
       end
in
   {Adjoin {Adjoin unit(metadata:  {Opt Metadata}
                        %privates:  Privates
                        symbols:   Symbols
                        cmps:      CMPs
                        fmp:       {Opt FMP}
                        hint:      {Opt Hint}
                        solutions: unit
                        mcs:       unit) R}
    E.attribs}
end

meth 'make_hint'(E $)
   Metadata#Symbols#CMPs#FMP = E.content
in
   {Adjoin unit(metadata: {Opt Metadata}
                %privates: Privates
                symbols:  Symbols
                cmps:     CMPs
                fmp:      {Opt FMP})
    E.attribs}
end
      
meth 'make_solution'(E $)
   R = case E.model of 'proof' then
          unit(proof: E.content
               model:proof)
       else
          Metadata#Symbols#CMPs#FMP = E.content
       in
          unit(metadata: {Opt Metadata}
               %privates: Privates
               symbols:  Symbols
               cmps:     CMPs
               fmp:      {Opt FMP}
               model: cfm)
       end
in
   {Adjoin R E.attribs}
end
      
meth 'make_mc'(E $)
   Symbols#Choice#Hint#Answer = E.content
in
   {Adjoin unit(symbols:  Symbols
                'choice': Choice
                hint:     {Opt Hint}
                answer:   Answer)
    E.attribs}
end

meth 'make_choice'(E $)
   Metadata#Symbols#CMPs#FMP = E.content
in
   {Adjoin unit(metadata: {Opt Metadata}
                %privates: Privates
                symbols:  Symbols
                cmps:     CMPs
                fmp:      {Opt FMP})
    E.attribs}
end
      
meth 'make_answer'(E $)
   Metadata#Symbols#CMPs#FMP = E.content
in
   {Adjoin unit(metadata: {Opt Metadata}
                %privates: Privates
                symbols:  Symbols
                cmps:     CMPs
                fmp:      {Opt FMP})
    E.attribs}
end

meth 'make_omlet'(E $)
   ANY = E.content in
   {AdjoinAt E.attribs content ANY}
end
      
meth 'make_private'(E $)
   Metadata#CMPs#Data = E.content
in
   {Adjoin unit(metadata: {Opt Metadata}
                cmps:     CMPs
                data:     Data)
    E.attribs}
end
      
meth 'make_code'(E $)
   Metadata#CMPs#Input#Output#Effect#Data = E.content
in
   {Adjoin unit(metadata: {Opt Metadata}
                cmps:     CMPs
                input:    {Opt Input}
                output:   {Opt Output}
                effect:   {Opt Effect}
                data:     Data)
    E.attribs}
end
      
meth 'make_input'(E $)
   CMPs = E.content in
   {AdjoinAt E.attribs cmps CMPs}
end
      
meth 'make_output'(E $)
   CMPs = E.content in
   {AdjoinAt E.attribs cmps CMPs}
end
      
meth 'make_effect'(E $)
   CMPs = E.content in
   {AdjoinAt E.attribs cmps CMPs}
end
      
meth 'make_data'(E $)
   ANY = E.content in
   {AdjoinAt E.attribs content ANY}
end

meth 'make_ignore'(E $)
   ANY = E.content in
   {AdjoinAt E.attribs content ANY}
end

meth 'make_presentation'(E $)
   Uses = E.content in
   {AdjoinAt E.attribs uses Uses}
end

meth 'make_use'(E $)
   %% #PCDATA
   {AdjoinAt E.attribs content E.content}
end


