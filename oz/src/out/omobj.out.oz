%%
%% printer for openmath objects
%%

functor
   
import
   Xml('class': XML) at 'x-ozlib://mathweb/omdoc/out/xml.out.ozf'
   
export
   'class':     NewOMWriter

   read:        ReadObject
   write:       WriteObject

   toXML:       OMOBJ2VS
   
define

   VS2BS = VirtualString.toByteString
   
   %%
   %% write OpenMath objects
   %%
   local
      ON = {VS2BS "on"}
      fun {IsLink X}
	 {HasFeature X xref}
      end
   in
      class Self = NewOMWriter
         from XML
    
         meth writeElems(L)
            {ForAll L
             proc {$ Elem}
		Self, writeElem(Elem)
             end}
         end
         
         %% simple elements
	 meth writeOMS(X)
	    XML, emptyTag(X)  % 'OMS'(cd:CD name:Name)
	 end
	 meth writeOMV(X)
	    XML, emptyTag(X) % 'OMV'(name:Name)
	 end
	 meth writeOMI(X)
	    %% XML, tag(X) % 'OMI'(I)
	    'OMI'(I) = X in
	    XML, startTag('OMI')
	    {self write(vs:I)}
	    XML, endTag('OMI' indent:false)
	 end
	 meth writeOMB(X)
	    XML, tag(X) % 'OMB'(BS)
	 end
	 meth writeOMSTR(X)
	    XML, tag(X) % 'OMSTR'(BS)
	 end
	 meth writeOMF(X)
	    'OMF'(F) = X in
	    XML, emptyTag('OMF'(dec:{Float.toString F}))
	 end
         %% complex elements
	 meth writeOMA(X)
	    case X of 'OMA'(F Args.../*'brackets-hint':_*/) then
	       Attribs = {Record.subtractList X [1 2]} in
	       if {VS2BS {CondSelect X 'brackets-hint' ''}}==ON
	       then XML, startTag({Record.subtract Attribs 'brackets-hint'})
	       else XML, startTag(Attribs)
	       end
	       Self, writeElem(F)
               Self, writeElems(Args)	       
               XML, endTag('OMA')
            [] 'OMA'(F|Args) then % hack for demo
               XML, startTag('OMA')
	       Self, writeElem(F)
               Self, writeElems(Args)
	       XML, endTag('OMA')
            end
	 end
	 meth writeOMBVAR(VarList)
	    XML, startTag('OMBVAR')
            Self, writeElems(VarList)
            XML, endTag('OMBVAR')
	 end
	 meth writeOMBIND(X)
            case X of 'OMBIND'(El1 VarList El2) then
	       XML, startTag('OMBIND')
	       Self, writeElem(El1)
	       Self, writeOMBVAR(VarList)
	       Self, writeElem(El2)
               XML, endTag('OMBIND')
            [] 'OMBIND'(El1#'OMBVAR'(VarList)#El2) then % hack for demo
               XML, startTag('OMBIND')
	       Self, writeElem(El1)
	       Self, writeOMBVAR(VarList)
	       Self, writeElem(El2)
               XML, endTag('OMBIND')
            end
         end
	 meth writeOME(X)
	    'OME'(Sym...) = X
	    Elems = {Value.condSelect X 2 nil} 
	 in
	    XML, startTag('OME')
	    Self, writeOMS(Sym)
	    Self, writeElems(Elems)
            XML, endTag('OME')
	 end
	 %%
	 meth writeOMATP(L)
	    XML, startTag('OMATP')
            {ForAll L
	     proc {$ Sym#Elem}
		Self, writeOMS(Sym)
		Self, writeElem(Elem)
             end}
            XML, endTag('OMATP')
	 end
	 meth writeOMATTR(X)
	    case X          %% order changed by jzimmer 19.4.2001
                            %% the more specific pattern must come first!
            of 'OMATTR'('OMATP'(L) Elem) then % hack for demo
               %% I don't know whose hack this is ^^^^^, but I changed it for my needs
               %% jzimmer 19.4.2001
               XML, startTag('OMATTR')
	       Self, writeOMATP(L)
	       Self, writeElem(Elem)
	       XML, endTag('OMATTR')
            [] 'OMATTR'(L Elem) then
	       XML, startTag('OMATTR')
	       Self, writeOMATP(L)
	       Self, writeElem(Elem)
	       XML, endTag('OMATTR')
            end
         end
	 meth writeElem(X)
	    case {Label X}
	    of 'OMS'    then Self, writeOMS(X)
	    [] 'OMV'    then Self, writeOMV(X)
	    [] 'OMI'    then Self, writeOMI(X)
	    [] 'OMB'    then Self, writeOMB(X)
	    [] 'OMSTR'  then Self, writeOMSTR(X)
	    [] 'OMF'    then Self, writeOMF(X)
	    [] 'OMA'    then Self, writeOMA(X)
	    [] 'OMBIND' then Self, writeOMBIND(X)
	    [] 'OME'    then Self, writeOME(X)
	    [] 'OMATTR' then Self, writeOMATTR(X)
	    end
	 end
	 meth writeOMOBJ(X)
	    if {IsLink X} then Self, writeLink(X)
	    else
	       'OMOBJ'(Elem...) = X in
	       XML, startTag({Record.subtract X 1})
	       Self, writeElem(Elem)
	       XML, endTag('OMOBJ')
	    end
	 end
	 meth writeLink(X)
	    XML, emptyTag(X)
	 end
      end
   end

   local
      class DummyWriter
         from NewOMWriter
         attr buff:nil
         meth init
            buff<-nil
         end
         meth write(vs:VS)
            buff<-@buff#VS
         end
         meth getAll(?VS)
            VS=@buff
            buff<-nil
         end
      end
   in
      fun {OMOBJ2VS OMOBJ}
         Writer = {New DummyWriter init} in
         {Writer writeOMOBJ(OMOBJ)}
         {Writer getAll($)}
      end
   end

   %%
   %% XXX needs clean up! yet another version...
   %%
   
   local   
      fun {WriteElems L WriteElem}
	 case L of nil then ''
	 [] X|R then
	    {WriteElem X}#{WriteElems R WriteElem}
	 end
      end
   in
      class OMWriter

	 attr
	    prefix: ''
	    tab:    '  '
	    
	 meth init(prefix: Prefix <= "\n"
		   tab:    Tab    <= "  ")
	    prefix <- Prefix
	    tab    <- Tab
	 end
	 meth setPrefix(Prefix)
	    prefix <- Prefix
	 end
	 meth setTab(N)
	    Tab = {List.make N}
	    {ForAll Tab proc {$ C} C=&  end}
	 in
	    tab <- Tab
	 end
	 meth shift(Tab<=@tab)
	    prefix <- @prefix#Tab
	 end
	 meth endshift
	    Prefix#_ = @prefix in
	    prefix <- Prefix
	 end
	 %% simple elements
	 meth WriteOMS(X $)
	    'OMS'(cd:CD name:Name) = X in
	    '<OMS cd="'#CD#'" name="'#Name#'"/>'
	 end
	 meth WriteOMV(X $)
	    'OMV'(name:Name) = X in
	    '<OMV name="'#Name#'"/>'
	 end
	 meth WriteOMI(X $)
	    'OMI'(I) = X in
	    '<OMI>'#I#'</OMI>' 
	 end
	 meth WriteOMB(X $)
	    'OMB'(BS) = X in
	    '<OMB>'#BS#'</OMB>'
	 end
	 meth WriteOMSTR(X $)
	    'OMSTR'(BS) = X in
	    '<OMSTR>'#BS#'</OMSTR>'
	 end
	 meth WriteOMF(X $)
	    'OMF'(F) = X in
	    '<OMF dec="'#{Float.toString F}#'"/>'
	 end
	 %% complex elements
	 meth WriteOMA(X $)
	    'OMA'(First Rest) = X in
	    '<OMA>'
	    #@prefix#@tab# OMWriter,WriteElem(First $)
	    #{WriteElems Rest
	     fun {$ Elem} @prefix#@tab# OMWriter,WriteElem(Elem $) end}
	    #@prefix#'</OMA>'
	 end
	 meth WriteOMBVAR(VarList ?VS)
	    OMWriter, shift
	    VS =
	    '<OMBVAR>'
	    #{WriteElems VarList
	     fun {$ Elem} @prefix#@tab# OMWriter,WriteElem(Elem $) end}
	    #@prefix#'</OMBVAR>'
	    OMWriter, endshift
	 end
	 meth WriteOMBIND(X $)
	    'OMBIND'(El1 VarList El2) = X in
	    '<OMBIND>'
	    #@prefix#@tab# OMWriter,WriteElem(El1 $)
	    #@prefix#@tab# OMWriter,WriteOMBVAR(VarList $)
	    #@prefix#@tab# OMWriter,WriteElem(El2 $)
	    #@prefix#'</OMBIND>'
	 end
	 meth WriteOME(X $)
	    'OME'(Sym...) = X
	    Elems = {Value.condSelect X 2 nil} 
	 in
	    '<OME>'
	    #@prefix#@tab# OMWriter,WriteOMS(Sym $)
	    #{WriteElems Elems
	      fun {$ Elem} @prefix#@tab# OMWriter,WriteElem(Elem $) end}
	    #@prefix#'</OME>'
	 end
	 meth WriteOMATP(L ?VS)
	    OMWriter, shift
	    VS =
	    '<OMATP>'
	    #{WriteElems L
	      fun {$ Sym#Elem}
		 @prefix#@tab# OMWriter,WriteOMS(Sym $)
		 #@prefix#@tab# OMWriter,WriteElem(Elem $)
	      end}
	    #@prefix#'</OMATP>'
	    OMWriter, endshift
	 end
	 meth WriteOMATTR(X $)
	    'OMATTR'(L Elem) = X in
	    '<OMATTR>'
	    #@prefix#@tab# OMWriter,WriteOMATP(L $)
	    #@prefix#@tab# OMWriter,WriteElem(Elem $)
	    #@prefix#'</OMATTR>'
	 end
	 meth WriteElem(X ?VS)
	    OMWriter, shift
	    case X
	    of 'OMS'(...)    then OMWriter,WriteOMS(X ?VS) 
	    [] 'OMV'(...)    then OMWriter,WriteOMV(X ?VS)
	    [] 'OMI'(...)    then OMWriter,WriteOMI(X ?VS)
	    [] 'OMB'(...)    then OMWriter,WriteOMB(X ?VS)
	    [] 'OMSTR'(...)  then OMWriter,WriteOMSTR(X ?VS)
	    [] 'OMF'(...)    then OMWriter,WriteOMF(X ?VS)
	    [] 'OMA'(...)    then OMWriter,WriteOMA(X ?VS)
	    [] 'OMBIND'(...) then OMWriter,WriteOMBIND(X ?VS)
	    [] 'OME'(...)    then OMWriter,WriteOME(X ?VS)
	    [] 'OMATTR'(...) then OMWriter,WriteOMATTR(X ?VS)
	    end
	    OMWriter, endshift
	 end
	 meth writeOMOBJ(X $)
	    'OMOBJ'(Elem) = X in
	    '<OMOBJ>'
	    #@prefix#@tab# OMWriter,WriteElem(Elem $)
	    #@prefix#'</OMOBJ>'
	 end
      end
   end
   

   %%
   %% standard format --> internal representation
   %%
   local
      fun {`OMS` X}
	 'OMS'(cd:CD name:Name) = X in
	 sym(cd:CD name:Name)
      end
      fun {`OMV` X}
	 'OMV'(name:Name) = X in
	 var(name:Name)
      end
      fun {`OMI` X}
	 'OMI'(I) = X in
	 int(I)
      end
      fun {`OMB` X}
	 'OMB'(BS) = X in
	 byteString(BS)
      end
      fun {`OMSTR` X}
	 'OMSTR'(BS) = X in
	 str(BS) 
      end
      fun {`OMF` X}
	 'OMF'(F) = X in
	 float(F)
      end
      fun {`OMA` X}
	 'OMA'(First Rest) = X in
	 app({ReadElem First} {Map Rest ReadElem})
      end
      fun {`OMBIND` X}
	 'OMBIND'(El1 VarList El2) = X in
	 bind({ReadElem El1} {Map VarList ReadElem} {ReadElem El2})
      end
      fun {`OME` X}
	 'OME'(Sym...) = X
	 Elements = {Value.condSelect X 2 nil}
      in
	 err({ReadElem Sym} {Map Elements ReadElem}) 
      end
      fun {`OMATTR` X}
	 'OMATTR'(L Elem) = X in
	 {AdjoinAt {ReadElem Elem} attribs
	  {Map L fun {$ Sym#Elem} {ReadElem Sym}#{ReadElem Elem} end}}
      end
      DoRead = unit('OMS':    `OMS`
		    'OMV':    `OMV`
		    'OMI':    `OMI` 
		    'OMB':    `OMB` 
		    'OMSTR':  `OMSTR` 
		    'OMF':    `OMF` 
		    'OMA':    `OMA` 
		    'OMBIND': `OMBIND` 
		    'OME':    `OME` 
		    'OMATTR': `OMATTR`)
      
      fun {ReadElem X}
	 {DoRead.{Label X} X}
      end
   in
      fun {ReadObject X}
	 'OMOBJ'(Elem) = X in
	 object({ReadElem Elem})
      end
   end

   %%
   %% internal representation --> standard format
   %%
   local
      fun {WriteElemSimple X}
	 case X
	 of sym(cd:CD name:Name) then 'OMS'(cd:CD name:Name)
	 [] var(name:Name)       then 'OMV'(name:Name)
	 [] int(I)               then 'OMI'(I)
	 [] byteString(BS)       then 'OMB'(BS)
	 [] str(BS)              then 'OMSTR'(BS)
	 [] float(F)             then 'OMF'(F)
	 [] app(First Rest) then
	    'OMA'({WriteElem First} {Map Rest WriteElem})
	 [] bind(X1 Vars X2) then
	    'OMBIND'({WriteElem X1} {Map Vars WriteElem} {WriteElem X2})
	 [] err(Sym Elements) then
	    'OME'({WriteElem Sym} {Map Elements WriteElem})
	 end
      end
      fun {WriteElem X}
	 if {HasFeature X attribs} then
	    L = {Map X.attribs fun {$ S#E} {WriteElem S}#{WriteElem E} end} in
	    'OMATTR'(L {WriteElemSimple {Record.subtract X attribs}})
	 else
	    {WriteElemSimple X}
	 end
      end
      Writer = {New OMWriter init}
   in
      fun {WriteObject X}
	 object(Y) = X
	 Y1 = {WriteElem Y}
      in
	 {Writer writeOMOBJ('OMOBJ'(Y1) $)}
      end
   end
end



