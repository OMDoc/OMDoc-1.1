%%%
%%% Parser semantics for OMDocs
%%%

functor

import
   SemOmobj       at 'omdobj.sem.ozf'
   SemMetadata    at 'metadata.sem.ozf'

   %%Browser(browse:Browse)
export
   'class': SemOmdoc
   
define

   fun {Opt X}
      case X of nil
      then unit
      else X
      end
   end
   
   fun {FilterLabel Xs L}
      {Filter Xs fun {$ X} {Label X}==L end}
   end

   class SemOmdoc
      from 
         SemOmobj.'class'
         SemMetadata.'class'

         \insert omdocmath.sem.oz
         \insert omdoctheory.sem.oz
         \insert omdocaux.sem.oz

      meth 'make_omdoc'(E $)
         Metadata#Catalogue#Items = E.content in
         %% XXX BUG: catalogue is also allowed as an attribute
         {Adjoin unit(metadata:  Metadata
                      catalogue: {Opt Catalogue}
                      items:     Items) % sort items?
          E.attribs}
      end

      meth 'make_catalogue'(E $)
         Locs = E.content in
         {AdjoinAt E.attribs items Locs}
      end

      meth 'make_loc'(E $)
         %% EMPTY
         E.attribs
      end
      
      meth 'make_omtext'(E $)
         Metadata#CMPs#FMPs = E.content
      in
         {Adjoin unit(metadata: {Opt Metadata}
                      cmps:     CMPs
                      fmps:     FMPs
                     )
          E.attribs}
      end

      meth 'make_CMP'(E $)
         %% E.content is an extended virtual string
         {AdjoinAt E.attribs content E.content}
      end
      
      meth 'make_omgroup'(E $)
         Metadata#Items = E.content
         %% Omgroups = {FilterLabel Items 'omgroup'}
         %% Refs     = {FilterLabel Items 'ref'}
      in
         {Adjoin unit(metadata: {Opt Metadata}
                      items:    Items
                      %% omgroups: Omgroups
                      %% refs:     Refs
                     )
          E.attribs}
      end

      meth 'make_ref'(E $)
         {AdjoinAt E.attribs content E.content}
      end

   end
 
end
