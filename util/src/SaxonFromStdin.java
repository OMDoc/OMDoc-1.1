
import org.xml.sax.*;
import com.icl.saxon.*;
import com.icl.saxon.om.*;
import com.icl.saxon.trax.TransformException;
import com.icl.saxon.trax.Transformer;
import com.icl.saxon.trax.Result;
import com.icl.saxon.output.*;
import java.util.Hashtable;
import java.util.Enumeration;



public class SaxonFromStdin {
// ==================
	
	public static void main(String[] args) throws Exception {
	// ==============
		new SaxonFromStdin(args[0]).process(null);
		}
	
	public final PreparedStyleSheet sheet; 

	public SaxonFromStdin(String pathOfXSL) throws SAXException {
	// ==========================
		InputSource sheetInput = new InputSource(pathOfXSL);
		this.sheet = new PreparedStyleSheet();
		//sheet.setURIResolver(getURIResolver());
		sheet.prepare(sheetInput);
		}
	
	public void process () throws TransformException {
		this.process(new Hashtable() );
		}

	public Transformer getTransformer(Hashtable params) {
	// =======================
		Transformer instance = sheet.newTransformer();
         if ( params != null ) {
            Enumeration paramNames = params.keys();
            while( paramNames.hasMoreElements() ) {
                String name = (String) paramNames.nextElement();
                instance.setParameter( name, "", params.get( name ) );					
                }
            }
		//URIResolver uriResolver = getURIResolver();
		//uriResolver.setURI( uriResolver.getURI(), "omdoc/src/c6s1p1.omdoc");
		//System.err.println("Interpreting the source to be from " + uriResolver.getURI() );
		//instance.setURIResolver( uriResolver );
		return instance;
		}


	public void process (Hashtable params, InputSource inputSource, Result result) throws TransformException {
	// =========================
		Transformer instance = getTransformer(params);
		instance.transform(inputSource, result); 
		}
	
	public void process(Hashtable params) throws TransformException {
	// ===========
		Transformer instance = getTransformer(params);
		InputSource in = new InputSource(System.in);
		Result out = new Result(System.out);
		getTransformer(params).transform(in, out);
		}
	
	} // class SaxonFromStdin