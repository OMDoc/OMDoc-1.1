%%
%% metadata writer
%%

functor

import
   Xml('class':XML) at 'x-ozlib://mathweb/omdoc/out/xml.out.ozf'

   Browser(browse:Browse)
   
export
   'class': MetadataWriter
%   writeMetadata: WriteMetadata
   
   writer: OMWriter
   
define
   XMLNS_DC = "http://purl.org/DC"
   
   class MetadataWriter
      from XML
         
      /*
      meth init(name:Name)
	 XML, init
	 Buffered.file, init(name:  Name 
			     flags: [write create]
			     mode:  mode(owner: [read write]  
					 group: [read write]))
         
      end
      */
      
      meth writeMetadata(M)
	 XML, startTag(metadata)
         /*
	 {Record.forAllInd M
          proc{$ F V}
             {self writeMetadataEntry(F V)}
          end}
         */
         {ForAll {CondSelect M items nil}
          proc {$ X}
             case X of 'depends-on'(TRefs) then
                {self writeDepends(TRefs)}
             else
                {self writeMetadataItem(X)}
             end
          end}
         %% todo: add support for extradata!
         %%...{CondSelect M extradata unit}...
	 XML, endTag(metadata)
      end

      meth writeMetadataItem(X)
         C|Sr = {AtomToString {Label X}}
         L = {StringToAtom {Char.toUpper C}|Sr}
         T =  case {CondSelect X 1 unit} of [VS] then
                 %% hack for new ANY content model
                 {AdjoinAt {Adjoin X L} 1 VS}
              else
                 {Adjoin X L}
              end
      in
         {self tag(T)}
      end
      meth writeDepends(TRefs)
         {self startTag('depends-on')}
         {ForAll TRefs
          proc {$ TRef}
             {self tag(TRef)}
          end}
         {self endTag('depends-on')}
      end
/* Alt      
      meth writeMetadataEntry(Kind Entry)
	 case Kind 
	 of contributor then
	    {self tag('Contributor'(Entry.string 'xmlns:dc':XMLNS_DC role:Entry.role))}
	 [] title then
	    {self tag('Title'(Entry.string 'xml:lang':Entry.'xml:lang' 'xmlns:dc':XMLNS_DC))}
	 [] creator then
	    {self tag('Creator'(Entry.string 'xmlns:dc':XMLNS_DC role:Entry.role))}	 
	 [] translator then
	    {self tag('Translator'(Entry.string 'xmlns:dc':XMLNS_DC 'xml:lang':Entry.'xml:lang'))}
	 [] subject then
	    {self tag('Subject'(Entry.string 'xmlns:dc':XMLNS_DC))}
	 [] description then
	    {self tag('Descrition'(Entry.string 'xmlns:dc':XMLNS_DC))}
	 [] publisher then
	    {self tag('Publisher'(Entry.string 'xmlns:dc':XMLNS_DC))}
	 [] date then
	    {self tag('Date'(Entry.string 'xmlns:dc':XMLNS_DC))}
	 [] type then
	    {self tag('Type'(Entry.string 'xmlns:dc':XMLNS_DC))}
	 [] format then
	    {self tag('Format'(Entry.string 'xmlns:dc':XMLNS_DC))}
	 [] identifier then
	    {self tag('Identifier'(Entry.string 'xmlns:dc':XMLNS_DC scheme:Entry.scheme))}
	 [] source then
	    {self tag('Source'(Entry.string 'xmlns:dc':XMLNS_DC))}
	 [] language then
	    {self tag('Language'(Entry.string 'xmlns:dc':XMLNS_DC))}
	 [] relation then
	    {self tag('Relation'(Entry.string 'xmlns:dc':XMLNS_DC))}
	 [] coverage then
	    {self tag('Coverage'(Entry.string 'xmlns:dc':XMLNS_DC))}
	 [] rights then
	    {self tag('Rights'(Entry.string 'xmlns:dc':XMLNS_DC))}
	 [] 'depends-on' then
	    {self tag('depends-on')}
	 else
            {Browse no_match#Kind}
            {self write(vs: "<<Unknown Kind: "#Kind#">>")}
	 end  
      end   
      */

   end

   %%
   %% afranke's old metadata printer
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
	 %% elements
	 meth WriteContributor(X $)
	    'Contributor'(BS...) = X in
	    if {HasFeature X role}
	    then '<Contributor role="'#X.role#'">'#BS#'</Contributor>'
	    else '<Contributor>'#BS#'</Contributor>'
	    end
	 end
	 meth WriteTitle(X $)
	    'Title'(BS) = X in
	    '<Title>'#BS#'</Title>'
	 end
	 meth WriteCreator(X $)
	    'Creator'(BS...) = X in
	    if {HasFeature X role}
	    then '<Creator role="'#X.role#'">'#BS#'</Creator>'
	    else '<Creator>'#BS#'</Creator>'
	    end
	 end
         meth WriteTranslator(X $)
            'Translator'(BS...) = X in
            if {HasFeature X lang}
            then '<Translator xml:lang="'#X.lang#'">'#BS#'</Translator>'
            else '<Translator>'#BS#'</Translator>'
            end
         end
	 meth WriteSubject(X $)
	    'Subject'(BS) = X in
	    '<Subject>'#BS#'</Subject>'
	 end
	 meth WriteDescription(X $)
	    'Description'(BS) = X in
	    '<Description>'#BS#'</Description>'
	 end
	 meth WritePublisher(X $)
	    'Publisher'(BS) = X in
	    '<Publisher>'#BS#'</Publisher>'
	 end
	 meth WriteDate(X $)
	    'Date'(BS) = X in
	    '<Date>'#BS#'</Date>'
	 end
	 meth WriteType(X $)
	    'Type'(BS) = X in
	    '<Type>'#BS#'</Type>'
	 end
	 meth WriteFormat(X $)
	    'Format'(BS) = X in
	    '<Format>'#BS#'</Format>' 
	 end
	 meth WriteIdentifier(X $)
	    'Identifier'(BS...) = X in
	    if {HasFeature X scheme}
	    then '<Identifier scheme="'#X.scheme#'">'#BS#'</Identifier>'
	    else '<Identifier>'#BS#'</Identifier>'
	    end
	 end
	 meth WriteSource(X $)
	    'Source'(BS) = X in
	    '<Source>'#BS#'</Source>'
	 end
	 meth WriteLanguage(X $)
	    'Language'(BS) = X in
	    '<Language>'#BS#'</Language>'
	 end
	 meth WriteRelation(X $)
	    'Relation'(BS) = X in
	    '<Relation>'#BS#'</Relation>'
	 end
	 meth WriteCoverage(X $)
	    'Coverage'(BS) = X in
	    '<Coverage>'#BS#'</Coverage>'
	 end
	 meth WriteRights(X $)
	    'Rights'(BS) = X in
	    '<Rights>'#BS#'</Rights>' 
	 end
	 meth WriteElem(X ?VS)
	    OMWriter, shift
	    case {Label X} 
	    of 'Contributor'  then OMWriter,WriteContributor(X ?VS) 
	    [] 'Title'        then OMWriter,WriteTitle(X ?VS)
	    [] 'Creator'      then OMWriter,WriteCreator(X ?VS)
	    [] 'Subject'      then OMWriter,WriteSubject(X ?VS)
	    [] 'Description'  then OMWriter,WriteDescription(X ?VS)
	    [] 'Publisher'    then OMWriter,WritePublisher(X ?VS)
	    [] 'Date'         then OMWriter,WriteDate(X ?VS)
	    [] 'Type'         then OMWriter,WriteType(X ?VS)
	    [] 'Format'       then OMWriter,WriteFormat(X ?VS)
	    [] 'Identifier'   then OMWriter,WriteIdentifier(X ?VS)
	    [] 'Source'       then OMWriter,WriteSource(X ?VS)
	    [] 'Language'     then OMWriter,WriteLanguage(X ?VS)
	    [] 'Relation'     then OMWriter,WriteRelation(X ?VS)
	    [] 'Coverage'     then OMWriter,WriteCoverage(X ?VS)
	    [] 'Rights'       then OMWriter,WriteRights(X ?VS)
	    end
	    OMWriter, endshift
	 end
	 meth writeMetadata(X $)
	    'metadata'(L) = X in
	    '<metadata>'
	    #{WriteElems L
	      fun {$ Elem} @prefix#@tab# OMWriter,WriteElem(Elem $) end}
	    #@prefix#'</metadata>'
	 end
      end
   end
end
   





