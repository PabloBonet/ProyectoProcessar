using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Xml;
using System.Runtime.InteropServices;
using System.Security;
using System.IO;
using ClienteLoginCms_CS;
using EntidadesClass;

namespace ModuloAFIP
{
    // [ClassInterface(ClassInterfaceType.AutoDual)]
    // [ProgId("ModuloAFIP.ModuloAFIP")]
    // public class ModuloAFIP : System.EnterpriseServices.ServicedComponent
    public class ModuloAFIP 
    {

        #region constantes
        // Valores por defecto, CONSTANTES

        const string DEFAULT_URLWSAAWSDL = "";
        //const string DEFAULT_URLWSAAWSDL_PRUEBA = "https://wsaahomo.afip.gov.ar/ws/services/LoginCms?WSDL";
        //const string DEFAULT_URLWSAAWSDL_PRODUCCION = "https://wsaa.afip.gov.ar/ws/services/LoginCms?WSDL";
        const string DEFAULT_SERVICIO = "wsfe";
        const string DEFAULT_CERTSIGNER = ""; //Certificado con clave privada
                                              //const string DEFAULT_CERTSIGNER_PRUEBA = ""; //Certificado con clave privada
                                              //const string DEFAULT_CERTSIGNER_PRODUCCION = ""; //Certificado con clave privada
        const string DEFAULT_PROXY = null;
        const string DEFAULT_PROXY_USER = null;
        const string DEFAULT_PROXY_PASSWORD = null;
        const string DEFAULT_TA_PRU = "";
        //const string DEFAULT_TA_PRU = "c:\\FE\\TA\\TicketAccesoPru.xml";
        //const string DEFAULT_TA_PRO = "c:\\FE\\TA\\TicketAccesoPro.xml";
        const string DEFAULT_CONFIGURACION = "";
        const int DEFAULT_CANTIDAD_INTENTOS = 10;
        const int DEFAULT_INTENTOS_OBTENER_TA = 10; //Cantidad de reintento de obtener el TA (mS)
        const int DEFAULT_INTERVALO_REINICIO = 60000; //Tiempo de reinicio en el caso de algún problema o que el autorizador no responda (mS), despues de X intentos
        const string DEFAULT_NOMBRE_EMPRESA = "";
        const string DEFAULT_CUIT_EMPRESA = "";
        const int DEFAULT_MODO_PRODUCCION = 0;
        const string DEFAULT_LOG = ".\\log.txt";

        #endregion

        #region propiedades

        //Propiedades

        private string _strUrlWsaaWsdl;                      //URL del servicio web de afip de autenticación
        private string _strIdServicioNegocio;                //ID servicio
        private string _strRutaCertSigner;                   //Ubicación del certificado firmado
        private string _strServAFIP;                         //URL del servicio web de afip de autorización
        //public string _strRutaCertSignerPru;               //Ubicación del certificado firmado de Prueba
        //public string _strRutaCertSignerPro;               //Ubicación del certificado firmado de Producción
        private SecureString _strPasswordSecureString;       //Contraseña de seguridad
        private string _strProxy;                            //Proxy de afip
        private string _strProxyUser;                        //Usuario de Proxy
        private string _strProxyPassword;                    //Contraseña de Proxy
        private string _strTicketAcceso;                     //Ubicaicón del Ticket de acceso
        //public string _strTicketAccesoPru;                 //Ubicaicón del Ticket de acceso de Prueba
        //public string _strTicketAccesoPro;                 //Ubicaicón del Ticket de acceso de Producción
        private string _strConfiguracion;                    //Ubicación del archivo de configuración
        private int _cantidadIntentosTA;                     //Cantidad de intentos de obtener TA
        private int _cantidadIntentosAFIP;                   //Cantidad de intentos de obtener respuesta afip
        private string _strEmpresa;                          //Nombre de la empresa que emite los comprobantes
        private string _strCuit;                             //CUIT de la empresa que emite los comprobantes
        private string _strLog;                              //Ubicación del archivo de LOG
        //public DispatcherTimer _dispatcherTimer;           //Variable utilizada para controlar el temporizador de lectura
        //public DispatcherTimer _dispatcherTimerObtenerTA;  //Variable utilizada para controlar el temporizador de obtención del TA
        //public DispatcherTimer _dispatcherTimerReinicio;   //Variable utilizada para controlar el temporizador de reinicio 
        private bool _error;                                 //Indica si hay errores
        private List<string> _errores;                       //Lista de errores (se actualizará cuando ocurra errores por cada metodo llamado)
        private LoginTicket _ticketAcceso;                   //Variable de Ticket de acceso
        //public FEClass _facturaElectronica;                //Variable de factura electrónica
        private FileStream _archivoLog;                      //Variable para manejar el archivo de log
        private StreamWriter _flujoEscritura;                //Variable para manejar el flujo de escritura
        private bool _configurado;                           //Indica si está configurado correctamente
        private FEClass _gestionFE;
        private List<string> _observaciones;                    //lista de observaciones
                                                                // private int _ptoVta;

        /// <summary>
        /// Propiedad que indica si hubo errores en algun procedimiento de la DLL
        /// </summary>
        /// 
        public bool Error
        {
            get { return _error; }
        }
        /// <summary>
        /// Retorna la lista de Errores
        /// </summary>
        public List<string> ListaErrores
        {
            get { return _errores; }
        }

        /// <summary>
        /// Propiedad que retorna la lista de errores
        /// </summary>
        public string Errores
        {
            get
            {
                string retorno = "";

                foreach (string s in _errores)
                {
                    retorno += s + "\n";
                }

                return retorno;
            }
        }

        /// <summary>
        /// Propiedad que indica si se cargó correctamente la configuración
        /// </summary>
        public bool Configurado
        {
            get { return _configurado; }
        }

        /// <summary>
        /// Asigna el nombre de la Empresa que va a utilizar el Servicio AFIP
        /// </summary>
        public string Empresa
        {
            get { return _strEmpresa; }
        }

        /// <summary>
        /// Retorna el nombre del Servicio de Autenticación del AFIP
        /// </summary>
        public string ServicioAutenticacion
        {
            get { return _strUrlWsaaWsdl; }
        }

        /// <summary>
        /// Retorna el nombre del Servicio de Autorización del AFIP
        /// </summary>
        public string ServicioAutorizacion
        {
            get { return _strServAFIP; }
        }

        /// <summary>
        /// Retorna o Asigna el Punto de Venta para ser usado en el servicio del AFIP
        /// </summary>
       /* public int PuntoVenta
        {
            get { return _ptoVta; }
            set { _ptoVta = value; }
        }
        */
        /// <summary>
        /// Retorna la ubicacion del Archivo de configuración
        /// </summary>
        public string UbicacionArchivoConfiguracion
        {
            get { return _strConfiguracion; }
        }

        /// <summary>
        /// Retorna la ubicación del archivo de LOG
        /// </summary>
        public string Log
        {
            get { return _strLog; }
        }
        #endregion

        #region Constructor

        /// <summary>
        /// Constructor por defecto de la clase ModuloAFIP
        /// </summary>
        public ModuloAFIP()
        {
            inicializar();

        }

        /// <summary>
        /// Retorna la lista de Observaciones
        /// </summary>
        public List<string> ListaObservaciones
        {
            get { return _observaciones; }
        }

        /// <summary>
        /// Retorna las observaciones como una única cadena separada por saltos de línea
        /// </summary>
        public string Observaciones
        {
            get
            {
                string retorno = "";

                foreach (string s in _observaciones)
                {
                    retorno += s + "\n";
                }

                return retorno;
            }
        }



        #endregion


        #region Métodos
        #region Métodos Privados
        /// <summary>
        /// Inicializa las propiedades del objeto llamando a la función de carga de configuración
        /// </summary>
        private void inicializar()
        {
            _configurado = false;
            _strConfiguracion = DEFAULT_CONFIGURACION;
            _strPasswordSecureString = null;
            _archivoLog = null;
            _flujoEscritura = null;
            _strLog = "";
            _error = false;
            _errores = new List<string>();
            _ticketAcceso = null;
            _observaciones = null;
            // _ptoVta = 0;
            _gestionFE = null;


            _configurado = cargaConfiguracionArchivo(_strConfiguracion); // Cargo el Archivo de configuración desde el XML

        }


        /// <summary>
        /// Carga la configuración desde el archivo XML de configuración seteado en _strConfiguracion
        /// </summary>
        /// <returns>Retorna True si se cargó correctamente el archivo, False en otro caso</returns>
        private bool cargaXMLConfiguracion(string ubicacionArchivoConf)
        {
            bool retorno = false;
        
            try
            {

                if (ubicacionArchivoConf == null || ubicacionArchivoConf.Length == 0) // Nombre del Archivo de configuración incorrecto
                {
                    _strConfiguracion = "";

                    retorno = false;
                }
                else
                {
                    _strConfiguracion = ubicacionArchivoConf;
                    XmlDocument configuracionXML = new XmlDocument();

                    configuracionXML.Load(_strConfiguracion);

                    _strIdServicioNegocio = configuracionXML.SelectSingleNode("//servicio").InnerText;
                    _strUrlWsaaWsdl = configuracionXML.SelectSingleNode("//serv_urlwsaawsdl").InnerText;
                    _strServAFIP = configuracionXML.SelectSingleNode("//serv_afip").InnerText;
                    _strProxy = configuracionXML.SelectSingleNode("//proxy").InnerText;
                    _strProxyUser = configuracionXML.SelectSingleNode("//proxy_user").InnerText;
                    _strProxyPassword = configuracionXML.SelectSingleNode("//proxy_pass").InnerText;
                    _strRutaCertSigner = configuracionXML.SelectSingleNode("//certificado").InnerText;
                    _strTicketAcceso = configuracionXML.SelectSingleNode("//ticket_acceso").InnerText;
                    _cantidadIntentosTA = Int32.Parse(configuracionXML.SelectSingleNode("//intentos_TA").InnerText);
                    _cantidadIntentosAFIP = Int32.Parse(configuracionXML.SelectSingleNode("//intentos_AUT").InnerText);
                    _strEmpresa = configuracionXML.SelectSingleNode("//nombre_empresa").InnerText;
                    _strCuit = UtilClass.cambiarFormatoCuitSinGuinoes(configuracionXML.SelectSingleNode("//cuit_empresa").InnerText);
                    _strLog = configuracionXML.SelectSingleNode("//log").InnerText;
                    retorno = true;
                }
            }
            catch (Exception e)
            {
                retorno = false;
            }



            return retorno;
        }


        /// <summary>
        /// Carga la configuración con los parámetros pasados
        /// </summary>
        /// <returns>Retorna True si se cargó correctamente el archivo, False en otro caso</returns>
        private bool cargaConfiguracionParametros(string servicio, string serv_urlwsaawsdl, string serv_afip, string proxy, string proxy_user, string proxy_pass, string certificado, string ticket_acceso, int intentos_aut, int intentos_ta, string nombre_empresa, string cuit_empresa, string log)
        {
            bool retorno = false;

            try
            {

                /*Validaciones */
                if (servicio == null || servicio.Length == 0) { return false; }
                if (serv_urlwsaawsdl == null || serv_urlwsaawsdl.Length == 0) { return false; }
                if (serv_afip == null || serv_afip.Length == 0) { return false; }
                if (certificado == null || certificado.Length == 0) { return false; }
                if (ticket_acceso == null || ticket_acceso.Length == 0) { return false; }
                if (nombre_empresa == null || nombre_empresa.Length == 0) { return false; }
                if (cuit_empresa == null || cuit_empresa.Length == 0) { return false; }

                _strIdServicioNegocio = servicio;
                _strUrlWsaaWsdl = serv_urlwsaawsdl;
                _strServAFIP = serv_afip;
                _strProxy = proxy;
                _strProxyUser = proxy_user;
                _strProxyPassword = proxy_pass;
                _strRutaCertSigner = certificado;
                _strTicketAcceso = ticket_acceso;
                _cantidadIntentosTA = intentos_ta;
                _cantidadIntentosAFIP = intentos_aut;
                _strEmpresa = nombre_empresa;
                _strCuit = UtilClass.cambiarFormatoCuitSinGuinoes(cuit_empresa);
                _strLog = log;
                retorno = true;

            }
            catch (Exception e)
            {
                retorno = false;
            }



            return retorno;
        }

        /// <summary>
        /// Agrega una observación a la lista de observaciones, controlando previamente que no sea nula o vacia
        /// </summary>
        /// <param name="observacion">Observación que se va a agregar a la lista de observaciones</param>
        /// <param name="conFecha">Agrega la fecha y hora actural a la observación pasada como parámetro</param>
        /// <returns>Retorna True si se agregó correctamente, False en otro caso</returns>
        private bool agregarObservaciones(string observacion, bool conFecha = false)
        {
            bool r = false;


            if (observacion != null && observacion.Length > 0)
            {



                if (conFecha)
                {
                    string strFechaHora = "";

                    DateTime fechaHora = DateTime.Now;

                    strFechaHora = fechaHora.ToString();

                    observacion = "[" + strFechaHora + "] " + observacion;
                }

                _observaciones.Add(observacion);
                r = true;

            }

            return r;
        }



        /// <summary>
        /// Carga el comprobante desde un archivo xml comprobando que coincida el idregistro
        /// </summary>
        /// <param name="ubicacionComp">Ubicación del archivo XML con información del comprobante a cargar</param>
        /// <param name="idregistro">IdRegistro del comprobante que se va a cargar, éste parámetro es para corroborar que se esté cargando el comprobante del ID pasado</param>
        /// <returns>Retorna el comprobante, Null en caso de que ocurra un error</returns>
        private ComprobanteClass cargaComprobante(string ubicacionComp, int idregistro)
        {
            ComprobanteClass retorno = null;
            _observaciones = new List<string>();
            _error = false;
            _errores = new List<string>();

            try
            {
                if (ubicacionComp == null || ubicacionComp.Length == 0) // Nombre del Archivo de configuración incorrecto
                {
                    _error = true;
                    _errores.Add("El nombre del Archivo de configuración es incorrecto");
                    retorno = null;
                }
                else
                {

                    XmlDocument compXML = new XmlDocument();

                    compXML.Load(ubicacionComp);

                    //Cargo los datos del comprobante desde el archivo XML
                    ComprobanteClass comprobante = new ComprobanteClass();

                    comprobante.IDComprobante = Int32.Parse(compXML.SelectSingleNode("//idfactura").InnerText);

                    if (comprobante.IDComprobante != idregistro)
                    {
                        _error = true;
                        _errores.Add("El ID del registro pasado como parámetro no coincide con el ID registro del archivo XML");
                        return null;
                    }
                    comprobante.PtoVta = Int32.Parse(compXML.SelectSingleNode("//puntov").InnerText);
                    comprobante.NroComprobante = Int32.Parse(compXML.SelectSingleNode("//numero").InnerText);
                    comprobante.TipoComprobante = Int32.Parse(compXML.SelectSingleNode("//codafip").InnerText);
                    comprobante.FechaComprobante = compXML.SelectSingleNode("//fecha").InnerText;
                    comprobante.DocTipoCliente = Int32.Parse(compXML.SelectSingleNode("//tipodoc").InnerText);
                    comprobante.NroDocCliente = compXML.SelectSingleNode("//nrodoccli").InnerText;
                    comprobante.ImporteNeto = Double.Parse((compXML.SelectSingleNode("//netocomp").InnerText).Replace('.', ','));

                    List<AlicuotaIvaClass> listaIva = new List<AlicuotaIvaClass>();
                    List<TributoComprobanteClass> listaTributo = new List<TributoComprobanteClass>();

                    Double totalIVA = 0;
                    Double totalTributo = 0;


                    // Cargo la lista de nodos del XML, cada nodo de la lista es un registro en la tabla de facturas de donde proviene el archivo xml
                    XmlNodeList listaNodosXml = compXML.SelectNodes("//tablafactura");
                    int cantNodos = listaNodosXml.Count;



                    for (int i = 0; i < cantNodos; i++)
                    {

                        XmlNode nodo = listaNodosXml.Item(i);

                        int id = Int32.Parse(nodo.SelectSingleNode("codigoafip").InnerText);
                        Double importe = Double.Parse((nodo.SelectSingleNode("importe").InnerText).Replace('.', ','));
                        Double baseImp = Double.Parse((nodo.SelectSingleNode("netoimpu").InnerText).Replace('.', ','));


                        string tipoAfip = nodo.SelectSingleNode("tipoafip").InnerText;

                        switch (tipoAfip)
                        {
                            case "IVA":
                                AlicuotaIvaClass alicuota = new AlicuotaIvaClass();

                                alicuota.ID = id;
                                alicuota.Importe = importe;
                                alicuota.BaseImp = baseImp;

                                comprobante.agruparAlicuotaIva(alicuota);

                                totalIVA += importe;

                                break;
                            case "TRIBUTO":

                                string detafip = nodo.SelectSingleNode("detafip").InnerText;

                                TributoComprobanteClass tributo = new TributoComprobanteClass();
                                tributo.ID = id;
                                tributo.Importe = importe;
                                tributo.BaseImponible = baseImp;
                                tributo.Descripcion = detafip;

                                comprobante.agruparTributo(tributo);

                                totalTributo += importe;
                                break;
                            default:
                                break;
                        }


                    }

                    comprobante.ImporteOpEx = Double.Parse((compXML.SelectSingleNode("//opexento").InnerText).Replace('.', ','));
                    comprobante.ImporteTributo = totalTributo;
                    comprobante.ImporteIva = totalIVA;
                    comprobante.ImporteTotal = Double.Parse((compXML.SelectSingleNode("//total").InnerText).Replace('.', ','));
                    comprobante.IDMoneda = compXML.SelectSingleNode("//idmoneda").InnerText;
                    comprobante.CotizacionMoneda = Double.Parse((compXML.SelectSingleNode("//cotmoneda").InnerText).Replace('.', ','));
                    comprobante.Concepto = Int32.Parse(compXML.SelectSingleNode("//concepto").InnerText);
                    comprobante.Resultado = compXML.SelectSingleNode("//resultado").InnerText;

                    retorno = comprobante;
                }
            }
            catch (Exception e)
            {
                _error = true;
                _errores.Add("Ocurrio un error: " + e.Message);
                return null;
            }

            return retorno;

        }



        #endregion

        #region Métodos Públicos


        /// <summary>
        /// Configura el ModuloAFIP con el archivo de configuracion pasado como parámetro
        /// </summary>
        /// <param name="ubicacionArchivoConf"></param>
        /// <returns>Retorna True si se cargó correctamente la configuración, False en otro caso</returns>
        public bool cargaConfiguracionArchivo(string ubicacionArchivoConf)
        {
            bool retorno = false;
            _observaciones = new List<string>();
            _error = false;
            _errores = new List<string>();

            try
            {
                bool xmlCargado = cargaXMLConfiguracion(ubicacionArchivoConf);

                if (xmlCargado) // Cargo Archivo de LOG y demás propiedades
                {
                    //Cargar Archivo de LOG
                    if (_strLog.Length > 0) // Si tiene asignado un archivo de log
                    {
                        if (!File.Exists(_strLog)) //Si no existe el archivo, lo creo
                        {

                            _archivoLog = new FileStream(_strLog, FileMode.OpenOrCreate);
                            _archivoLog.Close();

                            _archivoLog = new FileStream(_strLog, FileMode.Append, FileAccess.Write);

                            _flujoEscritura = new StreamWriter(_archivoLog);

                        }
                        else // Existe un archivo de Log creado
                        {
                            if (_archivoLog == null && _flujoEscritura == null)
                            {
                                _archivoLog = new FileStream(_strLog, FileMode.Append, FileAccess.Write);

                                _flujoEscritura = new StreamWriter(_archivoLog);
                            }
                        }
                    }
                    else // No hay asignado un archivo de log -> No se va a llevar un log
                    {
                        _archivoLog = null;
                        _flujoEscritura = null;
                        _strLog = "";

                    }

                    _strPasswordSecureString = new SecureString();
                    _error = false;
                    _errores = new List<string>();
                    _ticketAcceso = null;
                    _observaciones = new List<string>();

                    _gestionFE = new FEClass(_strServAFIP, _strCuit, _archivoLog, _flujoEscritura, _strLog);


                    // Cargo el ticket de Acceso



                    _ticketAcceso = _gestionFE.obtenerTicketAcceso(_strTicketAcceso, _strIdServicioNegocio, _strUrlWsaaWsdl, _strRutaCertSigner, _strPasswordSecureString, _strProxy, _strProxyUser, _strProxyPassword);
              
                    _observaciones.AddRange(_gestionFE.ListaObservaciones);
                    if (_ticketAcceso != null)
                    {
                        string fecha_expiracion = _ticketAcceso.ExpirationTime.ToString();

                        string mensaje = "Ticket de Acceso obtenido, válido hasta: " + fecha_expiracion + "\n";
                        //agregarObservaciones(mensaje, true);
                        UtilClass.escribirArchivoLog(mensaje, _archivoLog, _flujoEscritura, _strLog, true);
                        retorno = true;
                    }
                    else
                    {
                        string mensaje = "No se pudo obtener el Ticket de acceso\n";
                        //agregarObservaciones(mensaje, true);
                        UtilClass.escribirArchivoLog(mensaje, _archivoLog, _flujoEscritura, _strLog, true);
                        retorno = false;
                    }






                }
                else
                {
                    _strPasswordSecureString = null;
                    _archivoLog = null;
                    _flujoEscritura = null;
                    _strPasswordSecureString = null;
                    _strLog = "";
                    _error = true;
                    _errores = new List<string>();
                    _errores.Add("No se pudo cargar el Archivo XML de Configuración");
                    _ticketAcceso = null;
                    _observaciones = null;
                    _ticketAcceso = null;
                    retorno = false;
                }
            }
            catch (Exception e)
            {
                agregarObservaciones(e.Message, true);
                retorno = false;
            }

            _configurado = retorno;
            return retorno;
        }

        /// <summary>
        /// Configura el ModuloAFIP con los parámetros de configuración pasados
        /// </summary>
        /// <param name="servicio"></param>
        /// <param name="serv_urlwsaawsdl"></param>
        /// <param name="serv_afip"></param>
        /// <param name="proxy"></param>
        /// <param name="proxy_user"></param>
        /// <param name="proxy_pass"></param>
        /// <param name="certificado"></param>
        /// <param name="ticket_acceso"></param>
        /// <param name="intentos_aut"></param>
        /// <param name="intentos_ta"></param>
        /// <param name="nombre_empresa"></param>
        /// <param name="cuit_empresa"></param>
        /// <param name="log"></param>
        /// <returns></returns>
        public bool cargaConfiguracion(string servicio, string serv_urlwsaawsdl, string serv_afip, string proxy, string proxy_user, string proxy_pass, string certificado, string ticket_acceso, int intentos_aut, int intentos_ta, string nombre_empresa, string cuit_empresa, string log)
        {
            bool retorno = false;
            try
            {
                bool parametrosCargado = cargaConfiguracionParametros(servicio, serv_urlwsaawsdl, serv_afip, proxy, proxy_user, proxy_pass, certificado, ticket_acceso, intentos_aut, intentos_ta, nombre_empresa, cuit_empresa, log);

                if (parametrosCargado) // Cargo Archivo de LOG y demás propiedades
                {
                    //Cargar Archivo de LOG
                    if (_strLog.Length > 0) // Si tiene asignado un archivo de log
                    {
                        if (!File.Exists(_strLog)) //Si no existe el archivo, lo creo
                        {

                            _archivoLog = new FileStream(_strLog, FileMode.OpenOrCreate);
                            _archivoLog.Close();

                            _archivoLog = new FileStream(_strLog, FileMode.Append, FileAccess.Write);

                            _flujoEscritura = new StreamWriter(_archivoLog);

                        }
                        else // Existe un archivo de Log creado
                        {
                            if (_archivoLog == null && _flujoEscritura == null)
                            {
                                _archivoLog = new FileStream(_strLog, FileMode.Append, FileAccess.Write);

                                _flujoEscritura = new StreamWriter(_archivoLog);
                            }
                        }
                    }
                    else // No hay asignado un archivo de log -> No se va a llevar un log
                    {
                        _archivoLog = null;
                        _flujoEscritura = null;
                        _strLog = "";

                    }

                    _strPasswordSecureString = new SecureString();
                    _error = false;
                    _errores = new List<string>();
                    _ticketAcceso = null;
                    _observaciones = new List<string>();

                    _gestionFE = new FEClass(_strServAFIP, _strCuit, _archivoLog, _flujoEscritura, _strLog);


                 
                    // Cargo el ticket de Acceso



                    _ticketAcceso = _gestionFE.obtenerTicketAcceso(_strTicketAcceso, _strIdServicioNegocio, _strUrlWsaaWsdl, _strRutaCertSigner, _strPasswordSecureString, _strProxy, _strProxyUser, _strProxyPassword);
       
                    _observaciones.AddRange(_gestionFE.ListaObservaciones);
                    if (_ticketAcceso != null)
                    {
                        string fecha_expiracion = _ticketAcceso.ExpirationTime.ToString();

                        string mensaje = "Ticket de Acceso obtenido, válido hasta: " + fecha_expiracion + "\n";
                        //agregarObservaciones(mensaje, true);
                        UtilClass.escribirArchivoLog(mensaje, _archivoLog, _flujoEscritura, _strLog, true);
                        retorno = true;
                    }
                    else
                    {
                        string mensaje = "No se pudo obtener el Ticket de acceso\n";
                        //agregarObservaciones(mensaje, true);
                        UtilClass.escribirArchivoLog(mensaje, _archivoLog, _flujoEscritura, _strLog, true);
                        retorno = false;
                    }


                }
                else
                {
                    _strPasswordSecureString = null;
                    _archivoLog = null;
                    _flujoEscritura = null;
                    _strPasswordSecureString = null;
                    _strLog = "";
                    _error = true;
                    _errores = new List<string>();
                    _errores.Add("No se pudo cargar el Archivo XML de Configuración");
                    _ticketAcceso = null;
                    _observaciones = null;
                    _ticketAcceso = null;
                    retorno = false;
                }
            }
            catch (Exception e)
            {
                agregarObservaciones(e.Message, true);
                retorno = false;
            }

            _configurado = retorno;
            return retorno;
        }




        /// <summary>
        /// Prueba el servicio del AFIP
        /// </summary>
        /// <param name="nroComp">Número de Tipo de comprobante para usar como prueba</param>
        /// <returns></returns>
        public bool probarServicio(int ptoVta, int tipoComp = 1)
        {

            bool r = false;

            try
            {
                r = _gestionFE.probarServicio(_ticketAcceso, ptoVta, tipoComp);
                _error = false;
                _errores = new List<string>();

            }
            catch (Exception e)
            {
                r = false;
                _error = true;
                _errores.Add(e.Message);

            }

            return r;
        }


        public bool autorizarComp(string ubicacionComp, int idRegistro)
        {
            bool retorno = false;
            _observaciones = new List<string>();
            _error = false;
            _errores = new List<string>();
            try
            {
                if (ubicacionComp == null || ubicacionComp.Length == 0) // Nombre del Archivo de configuración incorrecto
                {
                    _error = true;
                    _errores.Add("El nombre del Archivo de configuración es incorrecto");
                    retorno = false;
                }
                else
                {
                 
                    ComprobanteClass comprobante = cargaComprobante(ubicacionComp, idRegistro);

                    if (comprobante != null)
                    {
                       
                        ComprobanteClass comprobanteRespuesta = null;
                        comprobanteRespuesta = _gestionFE.autorizarComprobante(_ticketAcceso, comprobante, idRegistro);


                        if (comprobanteRespuesta != null)
                        {
                                                      
                            try
                            {

                                if (ubicacionComp == null || ubicacionComp.Length == 0)
                                {
                                    Console.WriteLine("Ubicacion del comprobanteXML Vacia o nula");
                                }
                                else
                                {

                                    XmlDocument comprobanteXML = new XmlDocument();

                                    comprobanteXML.Load(ubicacionComp);

                                    comprobanteXML.SelectSingleNode("//cespcae").InnerText = comprobanteRespuesta.CAE;
                                    comprobanteXML.SelectSingleNode("//numero").InnerText = comprobanteRespuesta.NroComprobante.ToString();
                                    comprobanteXML.SelectSingleNode("//caecespven").InnerText = comprobanteRespuesta.FechaVtoCAE;
                                    comprobanteXML.SelectSingleNode("//resultado").InnerText = comprobanteRespuesta.Resultado;
                                    comprobanteXML.SelectSingleNode("//observa").InnerText = comprobanteRespuesta.ObservacionesAFIP;
                                    comprobanteXML.SelectSingleNode("//errores").InnerText = comprobanteRespuesta.ErroresAFIP;
                                    

                                    comprobanteXML.Save(ubicacionComp);
                                                                      
                                }
                            }
                            catch (Exception e)
                            {
                                _error = true;
                                _errores.Add("Ocurrio un error: " + e.Message);
                                return false;
                            }


                            retorno = true;
                        }
                        else
                        {
                          
                            retorno = false;
                        }

                    }
                    else
                    {
                       
                        retorno = false;
                    }

                }

            }
            catch (Exception e)
            {
                _error = true;
                _errores.Add("Ocurrio un error: " + e.Message);
                return false;
            }

            return retorno;

        }
        /*
           public string cargaXML(string ubicacionXML)
               {

                   string retorno = "";

                   try
                   {



                       XmlDocument documentoXML = new XmlDocument();


                       documentoXML.Load(ubicacionXML);


                       int idListaC = Int32.Parse(documentoXML.SelectSingleNode("//idlistac").InnerText);
                       int idLista = Int32.Parse(documentoXML.SelectSingleNode("//idlista").InnerText);
                       string detalle = documentoXML.SelectSingleNode("//detalle").InnerText;


                       retorno = "IdListaC: " + idListaC + "; idLista: " + idLista + "; Detalle: " + detalle;


                   }
                   catch (Exception e)
                   {
                       retorno = "";
                       return retorno;
                   }



                   return retorno;
               }
           */


        #endregion






        #endregion



    }
}
