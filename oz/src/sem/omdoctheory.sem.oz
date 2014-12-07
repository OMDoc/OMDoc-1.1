%%
%% parser semantics for omdoc theory items
%%

meth 'make_theory'(E $)
   Metadata#Commonnames#CMPs#Xs = E.content
   Imports    = {FilterLabel Xs 'imports'}
   Inclusions = {FilterLabel Xs 'inclusion'}
   Items      = {Filter Xs
		 fun {$ X}
		    {Member {Label X} ['imports' 'inclusion']}==false
		 end}
in
   {Adjoin unit(metadata:    {Opt Metadata}
                commonnames: Commonnames
		cmps:        CMPs
		imports:     Imports
		inclusions:  Inclusions
                items:       Items)
    E.attribs}
end
      
meth 'make_symbol'(E $)
   Metadata#CMPs#Xs = E.content
   Commonnames = {FilterLabel Xs 'commonname'}
   Types       = {FilterLabel Xs 'type'}
   Selectors   = {FilterLabel Xs 'selector'}
in
   {Adjoin unit(metadata: {Opt Metadata}
		cmps:        CMPs
                commonnames: Commonnames
                types:       Types
                selectors:   Selectors)
    E.attribs}
end
      
meth 'make_commonname'(E $)
   %% ANY, was: #PCDATA
   {AdjoinAt E.attribs string E.content}
end
      
meth 'make_signature'(E $)
   %% EMPTY
   E.attribs
end

meth 'make_type'(E $)
   %% OMOBJ
   {AdjoinAt E.attribs omobj E.content}
end
      
meth 'make_axiom'(E $)
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

meth 'make_definition'(E $)
   Metadata = E.content.1
   CMPs     = E.content.2
   X        = E.content.3
   Measure  = {CondSelect E.content 4 unit} % new omdoc.dtd, needed for PVS
   Ordering = {CondSelect E.content 5 unit} % new omdoc.dtd, needed for PVS
   %%{Browse E.model.3}
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
          [] unit then
          unit(model: unit)
          end
in
   {Adjoin {Adjoin unit(metadata:   {Opt Metadata}
                        cmps:       CMPs
                        fmps:       unit
                        requations: unit
                        omobj:      unit
                        measure:    {Opt Measure}
                        ordering:   {Opt Ordering}) R}
    E.attribs}
end
      
meth 'make_requation'(E $)
   Pattern#Value = E.content in
   {Adjoin unit(pattern: Pattern
                value:   Value)
    E.attribs}
end

meth 'make_pattern'(E $)
%   'OMOBJ'(E.content)
   E.content
end
      
meth 'make_value'(E $)
%   'OMOBJ'(E.content)
   E.content
end

meth 'make_measure'(E $)
   E.content
end

meth 'make_ordering'(E $)
   E.content
end

meth 'make_adt'(E $)
   Metadata#CMPs#Commonnames#Sortdefs = E.content
in
   {Adjoin unit(metadata:    {Opt Metadata}
                cmps:        CMPs
                commonnames: Commonnames
                sortdefs:    Sortdefs)
    E.attribs}
end
      
meth 'make_sortdef'(E $)
   Commonnames#Xs = E.content
   Constructors = {FilterLabel Xs 'constructor'}
   Insorts      = {FilterLabel Xs 'insort'}
in
   {Adjoin unit(commonnames:  Commonnames
                constructors: Constructors
                insorts:      Insorts)
    E.attribs}
end

meth 'make_constructor'(E $)
   Commonnames#Arguments = E.content
in
   {Adjoin unit(commonnames: Commonnames
                arguments:   Arguments)
    E.attribs}
end

meth 'make_argument'(E $) %% ???
   Selector = E.content in
   {AdjoinAt E.attribs selector {Opt Selector}}
end

meth 'make_insort'(E $)
   %% EMPTY
   E.attribs
end

meth 'make_selector'(E $)
   Commonnames = E.content in
   {AdjoinAt E.attribs commonnames Commonnames}
end

%%
%% support for theory inheritance
%%
      
meth 'make_imports'(E $)
   CMPs#Morphism = E.content in
   {Adjoin unit(cmps:     CMPs
                morphism: {Opt Morphism})
    E.attribs}
end
      
meth 'make_morphism'(E $)
   Requations = E.content in
   {AdjoinAt E.attribs requations Requations}
end
      
meth 'make_inclusion'(E $)
   %% EMPTY
   E.attribs
end

      




