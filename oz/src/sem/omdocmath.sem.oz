%%
%% parser semantics for omdoc math items
%%

%% begin old
/*
meth AssConc($)
   Ass=( Assumption($) )* Conc=Conclusion($) => Ass#Conc
end
meth Fmpel($)
   AssConc(Pair)     => assConc#Pair
[] FMP(FmpEl)        => fmp#FmpEl
[] FMPcomment(FmpC)  => fmpComment#FmpC
end
meth Cf(?CmpEl ?FmpEl ?FmpC)
   !CmpEl=[ CMP($) ] !FmpEl=[ FMP($) ] !FmpC=[ FMPcomment($) ] => skip
end
meth Cfm(MD CmpEl Pair)
   !MD=[ Metadata($) ] !CmpEl=[ CMP($) ] !Pair=[ CfmMain($) ] => skip
end
meth CfmMain($)
   Fmpel(Pair)  => Pair
[] OMGroup(X)   => 'omgroup'#X
end
*/
%% end old

meth 'make_FMP'(E $)
   case E.model of _#_ then
      Assumptions#Conclusion = E.content
   in
      {Adjoin unit(assumptions: Assumptions
                   conclusion:  Conclusion)
             E.attribs}
   [] 'OMOBJ' then
      {AdjoinAt E.attribs omobj E.content}
   end
end
      
meth 'make_assertion'(E $)
   L = {Width E.content}
   Metadata = E.content.1
   Privates = if L==5 then E.content.2 else nil end
   Symbols  = E.content.(L-2)
   CMPs     = E.content.(L-1)
   FMP      = E.content.L
in
   {Adjoin unit(metadata: {Opt Metadata}
                privates: Privates
                symbols:  Symbols
                cmps:     CMPs
                fmp:      {Opt FMP})
    E.attribs}
end

meth 'make_assumption'(E $)
   CMPs#OMOBJ = E.content
in
   {Adjoin unit(cmps:  CMPs
                omobj: {Opt OMOBJ})
    E.attribs}
end
      
meth 'make_conclusion'(E $)
   CMPs#OMOBJ = E.content
in
   {Adjoin unit(cmps:  CMPs
                omobj: {Opt OMOBJ})
    E.attribs}
end
      
meth 'make_alternative-def'(E $)
   Metadata#CMPs#X = E.content
   %% {Browse E.model.3}
   R = case E.model.3
       of 'FMP' then
          unit(model: fmp
               fmp: X)
       [] list('requation'...) then
          unit(model: requations
               requations: X)
       [] 'OMOBJ' then
          unit(model: omobj
               omobj: X)
       end
in
   {Adjoin {Adjoin unit(metadata:   {Opt Metadata}
                        cmps:       CMPs
                        fmp:        unit
                        requations: nil
                        omobj:      unit) R}
    E.attribs}
end
      
meth 'make_proof'(E $)
   Metadata#Symbols#CMPs#Xs#Conclude = E.content
   Metacomments = {FilterLabel Xs 'metacomment'}
   Derives      = {FilterLabel Xs 'derive'}
   Hypotheses   = {FilterLabel Xs 'hypothesis'}
in
   {Adjoin unit(metadata:     {Opt Metadata}
                symbols:      Symbols
                cmps:         CMPs
                metacomments: Metacomments
                derives:      Derives
                hypotheses:   Hypotheses
                conclude:     Conclude)
    E.attribs}
end

meth 'make_proofobject'(E $)
   CMPs#OMOBJ = E.content
in
   {Adjoin unit(cmps:  CMPs
                omobj: OMOBJ)
    E.attribs}
end
      
meth 'make_metacomment'(E $)
   CMPs = E.content in
   {AdjoinAt E.attribs cmps CMPs}
end
      
meth 'make_derive'(E $)
   CMPs#FMP#Method#Premises#Prf = E.content
   R = case E.model.5
       of 'proof' then
          unit(model: 'proof'
               proof: Prf)
       [] 'proofobject' then
          unit(model: 'proofobject'
               proofobject: Prf)
       [] unit then
          unit(model: unit)
       end
in
   {Adjoin {Adjoin unit(cmps:        CMPs
                        fmp:         {Opt FMP}
                        method:      {Opt Method}
                        premises:    Premises
                        proof:       unit
                        proofobject: unit) R}
    E.attribs}
end

meth 'make_conclude'(E $)
   CMPs#Method#Premises#Prf = E.content
   R = case E.model.4
       of 'proof' then
          unit(model: 'proof'
               proof: Prf)
       [] 'proofobject' then
          unit(model: 'proofobject'
               proofobject: Prf)
       [] unit then
          unit(model: unit)
       end
in
   {Adjoin {Adjoin unit(cmps:        CMPs
                        method:      {Opt Method}
                        premises:    Premises
                        proof:       unit
                        proofobject: unit) R}
    E.attribs}
end
          
meth 'make_hypothesis'(E $)
   Symbols#CMPs#FMP = E.content
in
   {Adjoin unit(symbols: Symbols
                cmps:    CMPs
                fmp:     {Opt FMP})
    E.attribs}
end

meth 'make_method'(E $)
   X#Parameters = E.content
   R = case E.model.1
       of 'ref' then
          unit(ref:  X
               model: ref)
       [] 'OMSTR' then
          unit(string: X
               model:  string)
       end
in
   {Adjoin {Adjoin unit(ref:        unit
                        string:     unit
                        parameters: Parameters) R}
    E.attribs}
end
      
meth 'make_parameter'(E $)
   %% OMOBJ
   E.content
end

meth 'make_premise'(E $)
   %% EMPTY
   E.attribs
end
      
meth 'make_example'(E $)
   Metadata#Symbols#CMPs#OMOBJ = E.content
in
   {Adjoin unit(metadata: {Opt Metadata}
                symbols:  Symbols
                cmps:     CMPs
                omobj:    OMOBJ)
    E.attribs}
end

meth 'make_axiom-inclusion'(E $)
   Metadata#Morphism#Just = E.content
   R = case E.model.3
       of 'path-just' then
          unit('path-just': Just
               model: 'path-just')
       [] 'assertion-just' then
          unit('assertion-just': Just
               model: 'assertion-just')
       end
in
   {Adjoin {Adjoin unit(metadata:         {Opt Metadata}
                        morphism:         {Opt Morphism}
                        'path-just':      unit
                        'assertion-just': unit) R}
    E.attribs}
end

meth 'make_theory-inclusion'(E $)
   Metadata#Morphism#Decomposition = E.content
in
   {Adjoin unit(metadata:      {Opt Metadata}
                morphism:      Morphism
                decomposition: {Opt Decomposition})
    E.attribs}
end
      
meth 'make_path-just'(E $)
   %% EMPTY
   E.attribs
end

meth 'make_assertion-just'(E $)
   %% EMPTY
   E.attribs
end

meth 'make_decomposition'(E $)
   %% EMPTY
   E.attribs
end





