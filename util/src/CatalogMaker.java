


//
//  CatalogMaker.java
//
import java.util.Vector;
import java.util.Enumeration;
import java.util.Hashtable;

import java.io.File;
import java.io.IOException;
import java.io.Reader;
import java.io.InputStreamReader;
import java.io.FileReader;
import java.io.File;
import java.io.FileWriter;

import org.xml.sax.Attributes;
import org.xml.sax.SAXException;
import org.xml.sax.XMLReader;

/** 
	The CatalogMaker utility creates a catalog from all the OMdocs contained in the parameter
	line or in directories of the parameter-lines.
	The catalog produced is relative to the current directory, not the directory of the catalogue.
	This relativity is even greater when inserting a baseURL option (which is though for http).
	
	If the catalog exists, then it is only enriched, i.e. the </catalog> element is replaced by
	the output. This enables to apply CatalogMaker on your preferred OMdoc type, 
	including the DTD reference and all possible metadata.
	For a sitewise configuration, please modify the "EmptyCatalog.omdoc" file in the jar that
	contains CatalogMaker.
	
	Please send any comments or bugs to paul@mathweb.org
	
	java CatalogMaker [-o catalogueName.omdoc] [-b baseURL] omdocName|directoryName [... other names]
	*/

public class CatalogMaker {
// ====================== 
	
	String outputName = null;
	String baseURL = "";
	Vector filesOrDirs = new Vector();

	public CatalogMaker (String[] args) {
		parseArguments(args);
		run();
		}

	
	public void parseArguments(String[] args) {
	// ==================
		int c = 0;
		for (; c < args.length; c++ ) {
			if ( args[c] == null || args.length == 0 ) continue;
			if ( args[c].charAt(0) == '-' ) { // an option
				if ( args[c].length() == 1 )
					{ filesOrDirs.addElement(args[c]); continue; }
				
				if ( args[c].charAt(1) == 'h' ) {
					printErrorAndUsage(null);
					}
				if ( args[c].charAt(1) == 'o' ) {
					if ( c+1 == args.length )
						printErrorAndUsage("The 'o' option needs a fileName.");
					outputName = args[++c]; 
					} 
				else if ( args[c].charAt(1) == 'b' ) {
					if ( c+1 == args.length )
						printErrorAndUsage("The 'b' option needs a URL to append.");
					baseURL = args[++c];
					}
				else printErrorAndUsage("No such option : " + args[c] );
				}
			else { // not an option
				filesOrDirs.addElement ( args[c] );
				}
			}
		}
	
	
	private static void printErrorAndUsage (String errorMessage ) {
	// ==================================
		if ( errorMessage != null ) 
			System.err.println ( " -- error : " + errorMessage );
		System.err.println ("	");
		System.err.println ( "Usage: java CatalogMaker ");
		System.err.println ("             [-o catalogueName.omdoc] [-b baseURL]");
		System.err.println ("             omdocName|directoryName [... other names]" );
		System.err.println ("	");
		System.err.println ("	The CatalogMaker utility creates a catalog from all ");
		System.err.println ("	the OMdocs contained in the parameter line or ");
		System.err.println ("	in directories of the parameter-lines.");
		System.err.println ("	The catalog produced is relative to the ");
		System.err.println ("	current directory, not the directory of the catalogue.");
		System.err.println ("	This relativity is even greater when inserting a baseURL");
		System.err.println ("	option (which is though for http).");
		System.err.println ("	");
		System.err.println ("	If the catalog exists, then it is only enriched, i.e. ");
		System.err.println ("	the </catalog> element is replaced by the output. ");
		System.err.println ("	This enables to apply CatalogMaker on your preferred OMdoc type, ");
		System.err.println ("	including the DTD reference and all possible metadata.");
		System.err.println ("	For a sitewise configuration, please modify the");
		System.err.println ("	 \"EmptyCatalog.omdoc\" file in the jar that contains CatalogMaker.");
		System.err.println ("	");
		System.err.println ("		Please send any comments or bugs to paul@mathweb.org");
		System.err.println ("	");


		if ( errorMessage != null ) System.exit(1);
		else System.exit(0);
		}
	
	private static void printErrorAndQuit (String errorMessage) {
	// ==================================
		System.err.println ( errorMessage );
		if ( errorMessage != null ) System.exit(1);
		else System.exit(0);
		}
	

    public static void main (String args[]) {
	// =====================
		new CatalogMaker ( args );
		}



//	public Document catDoc = null;
	public Hashtable locFromTheories = new Hashtable();
	
	public void run() {
	// =============
		// read document before ??
		Enumeration fod = filesOrDirs.elements();
		while ( fod.hasMoreElements() ) {
			readFileOrDir ( (String) fod.nextElement() );
			}
		// then create document
		//System.out.println( locFromTheories );
		try {
			produceFile();
			}
		catch (IOException ex) {
			printErrorAndQuit (ex.getMessage() );
			}
		}

	
	public static final String fileSeparator = System.getProperty("file.separator");

	private void readFileOrDir ( String path ) {
	// -----------------------
		try {
			File file = new File ( path );
			if ( ! file.exists() ) {
				printErrorAndQuit ( " No such file or directory: " + path );
				}
			if ( ! file.canRead() ) {
				printErrorAndQuit ( " Unreadable file or directory: " + path );
				}
			if ( file.isDirectory() ) { // parse list
				String[] files = file.list();
				for ( int i=0; i< files.length; i++) {
					File f = new File ( file, files[i] );
					if ( f.isDirectory () )
						readFileOrDir ( path + fileSeparator + files[i] );
					else if ( files[i].endsWith(".omdoc")){
						readFileOrDir ( path + fileSeparator + files[i] );
						}
					}
				}
			else { // a real file: either a .omdoc from within a directory
					// or a file indicated on the command-line (with or without .omdoc)
				readFile ( path );
				}
			}
		catch ( IOException e) {
			printErrorAndQuit ( e.getMessage() );
			}
		}


	public void readFile ( String path ) throws IOException {
	// =================
		try { 
			new SAXtheoryListener ( path );
			}
		catch (Exception e) {
			e.printStackTrace();
			printErrorAndQuit ("Error when reading document.");
			}
		}
	
	
	public class SAXtheoryListener extends org.xml.sax.helpers.DefaultHandler {
		
		protected String path;
		
		public SAXtheoryListener ( String path ) throws org.xml.sax.SAXException {
		// ---------------------
			this.path = path;
			System.out.println("Should be reading file " + path );
			// if ( ! file.exists() ) throw new org.xml.sax.SAXException("Huh ?");
			try {
				XMLReader parser = (XMLReader)
					Class.forName("com.icl.saxon.aelfred.SAXDriver").newInstance();
				parser.setContentHandler ( this );
				parser.setEntityResolver ( this );
				parser.setDTDHandler ( this );
				//parser.setErrorHandler ( this );
				if ( ! path.toLowerCase().startsWith("http:") && ! path.toLowerCase().startsWith("ftp:" ) && ! path.toLowerCase().startsWith("file:") )
					path = "file:" + path;
				parser.parse ( path );
				}
			catch (Exception ex) {
				ex.printStackTrace();
				printErrorAndQuit ("Error when reading document.");
				}
				
			}
		
		public void startElement( String uri, String localName, String qName, Attributes attributes) {
		// ====================
			String name = null;
			if ( localName != null ) name = localName;
			else if ( qName != null ) name = qName;
			if ( name == null ) return;
			int k = name.indexOf(":");
			if ( k != -1 && k+1 < name.length() ) name = name.substring(k);
			
			if ( "theory".equals(name) ) {
				String id = attributes.getValue("id");
				if ( id == null ) id = attributes.getValue("http://www.mathweb.org/omdoc/dtd/omdoc.dtd", "id");
				addEntryInTable ( attributes.getValue("id"), path);
				}
			}

		
		} // class SAXtheoryListener
	
	public void addEntryInTable ( String theoryName, String path ) {
	// ========================
		String previous = (String) locFromTheories. put ( theoryName, path );
		if ( previous != null ) {
			System.err.println("Warning theory \"" + theoryName + "\" defined in two places : ");
			System.err.println("    -> " + previous );
			System.err.println("    -> " + path );
			}
		}


	public void produceFile () throws IOException {
	// ====================
		// load the catalogue
		Reader reader;
		int bufSize = 512;
		File outputFile = new File ( outputName);
		if ( outputName == null || ! outputFile.exists() ) {
			bufSize = 512;
			reader = new InputStreamReader( this.getClass().getResourceAsStream("EmptyCatalog.omdoc"), "UTF-8");
			if ( outputName == null ) outputName = "catalogue.omdoc";
			}
		else {
			reader = new FileReader ( outputName );
			bufSize = (int) new File( outputName ).length();
			}
		StringBuffer buff = new StringBuffer (bufSize);
		for ( int r = reader.read(); r != -1; r = reader.read()) 
			buff.append((char) r);
		reader.close();
		String current = buff.toString();
		int p = current.indexOf("</catalogue>");
		if ( p == -1 )
			printErrorAndQuit (" The indicated output does not contain a catalogue element. Please delete the file and restart CatalogMaker");
		
		// write
		FileWriter writer = new FileWriter ( outputName);
		writer.write(current.substring(0, p));
		Enumeration enum = locFromTheories.keys();
		while ( enum.hasMoreElements() ) {
			String theoryName = (String) enum.nextElement();
			String loc = baseURL + (String) locFromTheories.get( theoryName );
			String locElement = "<loc theory=\"" + theoryName + "\" omdoc=\"" + loc + "\"/>";
			writer.write(locElement + "\n");
			}
		writer.write( current.substring( p ));
		writer.flush(); writer.close();
		}


	} // class CatalogMaker
