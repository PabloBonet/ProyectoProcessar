﻿using System;
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
       
        const string DEFAULT_CONFIGURACION = "";
     
        #endregion

        #region propiedades

        //Propiedades

        private string _strUrlWsaaWsdl;                      //URL del servicio web de afip de autenticación
        private string _strIdServicioNegocio;                //ID servicio
        private string _strIdServicioPersona;
        private string _strRutaCertSigner;                   //Ubicación del certificado firmado
        private string _strServAFIP;                         //URL del servicio web de afip de autorización
        private string _strServContrib;                      //URL del servicio web de afip para datos del contribuyente
        private SecureString _strPasswordSecureString;       //Contraseña de seguridad
        private string _strProxy;                            //Proxy de afip
        private string _strProxyUser;                        //Usuario de Proxy
        private string _strProxyPassword;                    //Contraseña de Proxy
        private string _strTicketAcceso;                     //Ubicaicón del Ticket de acceso
        private string _strConfiguracion;                    //Ubicación del archivo de configuración
        private string _strEmpresa;                          //Nombre de la empresa que emite los comprobantes
        private string _strCuit;                             //CUIT de la empresa que emite los comprobantes
        private string _strLog;                              //Ubicación del archivo de LOG
        private bool _error;                                 //Indica si hay errores
        private List<string> _errores;                       //Lista de errores (se actualizará cuando ocurra errores por cada metodo llamado)
        private LoginTicket _ticketAcceso;                   //Variable de Ticket de acceso
        private LoginTicket _ticketAccesoContrib;            //Variable de Ticket de acceso WS personas
       // private FileStream _archivoLog;                      //Variable para manejar el archivo de log
    //    private StreamWriter _flujoEscritura;                //Variable para manejar el flujo de escritura
        private bool _configurado;                           //Indica si está configurado correctamente
        private FEClass _gestionFE;
        private List<string> _observaciones;                    //lista de observaciones
        private ContribuyenteClass _gestionContribuyente;   
                                                       

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


        public string ServicioContribuyente
        {
            get { return _strServContrib; }
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
            Inicializar();

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
        private void Inicializar()
        {
            _configurado = false;
            _strConfiguracion = DEFAULT_CONFIGURACION;
            _strPasswordSecureString = null;
        //    _archivoLog = null;
        //    _flujoEscritura = null;
            _strLog = "";
            _error = false;
            _errores = new List<string>();
            _ticketAcceso = null;
            _ticketAccesoContrib = null;
            _observaciones = null;
            _gestionFE = null;
            _gestionContribuyente = null;

            _configurado = CargaConfiguracionArchivo(_strConfiguracion); // Cargo el Archivo de configuración desde el XML

        }


        /// <summary>
        /// Carga la configuración desde el archivo XML de configuración seteado en _strConfiguracion
        /// </summary>
        /// <returns>Retorna True si se cargó correctamente el archivo, False en otro caso</returns>
        private bool CargaXMLConfiguracion(string ubicacionArchivoConf)
        {
            bool retorno ;
        
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
                    _strIdServicioPersona = configuracionXML.SelectSingleNode("//servicioper").InnerText;
                    _strUrlWsaaWsdl = configuracionXML.SelectSingleNode("//serv_urlwsaawsdl").InnerText;
                    _strServAFIP = configuracionXML.SelectSingleNode("//serv_afip").InnerText;
                    _strProxy = configuracionXML.SelectSingleNode("//proxy").InnerText;
                    _strProxyUser = configuracionXML.SelectSingleNode("//proxy_user").InnerText;
                    _strProxyPassword = configuracionXML.SelectSingleNode("//proxy_pass").InnerText;
                    _strRutaCertSigner = configuracionXML.SelectSingleNode("//certificado").InnerText;
                    _strTicketAcceso = configuracionXML.SelectSingleNode("//ticket_acceso").InnerText;
                   // _cantidadIntentosTA = Int32.Parse(configuracionXML.SelectSingleNode("//intentos_TA").InnerText);
                    //_cantidadIntentosAFIP = Int32.Parse(configuracionXML.SelectSingleNode("//intentos_AUT").InnerText);
                    _strEmpresa = configuracionXML.SelectSingleNode("//nombre_empresa").InnerText;
                    _strCuit = UtilClass.CambiarFormatoCuitSinGuiones(configuracionXML.SelectSingleNode("//cuit_empresa").InnerText);
                    _strLog = configuracionXML.SelectSingleNode("//log").InnerText;
                    _strServContrib = configuracionXML.SelectSingleNode("//serv_contrib").InnerText;
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
        private bool CargaConfiguracionParametros(string servicio, string serv_urlwsaawsdl, string serv_afip, string proxy, string proxy_user, string proxy_pass, string certificado, string ticket_acceso, int intentos_aut, int intentos_ta, string nombre_empresa, string cuit_empresa, string log, string serv_contrib, string servicioper)
        {
            bool retorno;

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
                //if (serv_contrib == null || serv_contrib.Length == 0) { return false; }
                //if (servicioper == null || servicioper.Length == 0) { return false; }

                if (serv_contrib == null) { return false; }
                if (servicioper == null) { return false; }

                _strIdServicioNegocio = servicio;
                _strIdServicioPersona = servicioper;
                _strUrlWsaaWsdl = serv_urlwsaawsdl;
                _strServAFIP = serv_afip;
                _strProxy = proxy;
                _strProxyUser = proxy_user;
                _strProxyPassword = proxy_pass;
                _strRutaCertSigner = certificado;
                _strTicketAcceso = ticket_acceso;
             //   _cantidadIntentosTA = intentos_ta;
             //   _cantidadIntentosAFIP = intentos_aut;
                _strEmpresa = nombre_empresa;
                _strCuit = UtilClass.CambiarFormatoCuitSinGuiones(cuit_empresa);
                _strLog = log;
                _strServContrib = serv_contrib;
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
        private bool AgregarObservaciones(string observacion, bool conFecha = false)
        {
            bool r = false;


            if (observacion != null && observacion.Length > 0)
            {

                if (conFecha)
                {
                    string strFechaHora;

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
        private ComprobanteClass CargaComprobante(string ubicacionCompAso, int idregistro,string cuitEmisor)
        {

          
            ComprobanteClass retorno;
            _observaciones = new List<string>();
            _error = false;
            _errores = new List<string>();

            try
            {
                if (ubicacionCompAso == null || ubicacionCompAso.Length == 0) // Nombre del Archivo de configuración incorrecto
                {
                    _error = true;
                    _errores.Add("El nombre del Archivo de configuración es incorrecto");
                    retorno = null;
                }
                else
                {

                    string[] ubicaciones = ubicacionCompAso.Split(';');


                    string ubicacionComp = "";
                    string ubicacionAso = "";

                    int cantUbi = ubicaciones.Length;

                    switch (cantUbi)
                    {

                        case 1:
                            ubicacionComp = ubicaciones[0];
                            ubicacionAso = "";
                            break;
                        case 2:
                            ubicacionComp = ubicaciones[0];
                            ubicacionAso = ubicaciones[1];
                            break;
                        default:


                            _error = true;
                            _errores.Add("El ID del registro pasado como parámetro no coincide con el ID registro del archivo XML");
                            return null;
                           
                    }

                    
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
                    comprobante.FechaVtoPago = compXML.SelectSingleNode("//fchvtopago").InnerText;
                    
                    List<AlicuotaIvaClass> listaIva = new List<AlicuotaIvaClass>();
                    List<TributoComprobanteClass> listaTributo = new List<TributoComprobanteClass>();

                    Double totalIVA = 0.0f;
                    Double totalTributo = 0.0f;
                    Double totalImpEx = 0.0f;
                    Double totalNoGrav = 0.0f;

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

                               
                                UtilClass.EscribirArchivoLog("ID: "+id, _strLog, true);

                                if (id > 2)
                                {
                                    alicuota.ID = id;
                                    alicuota.Importe = importe;
                                    alicuota.BaseImp = baseImp;

                                    comprobante.agruparAlicuotaIva(alicuota);
                                }
                                else
                                {
                                    if (id == 1) //IVA - NO GRAVADO
                                    {
                                        UtilClass.EscribirArchivoLog("ID(1)", _strLog, true);
                                        totalNoGrav += baseImp;
                                        comprobante.ImporteNeto -= totalNoGrav;

                                        UtilClass.EscribirArchivoLog("totalNoGrav: " + totalNoGrav, _strLog, true);

                                        UtilClass.EscribirArchivoLog(" comprobante.ImporteNeto: " + comprobante.ImporteNeto, _strLog, true);

                                    }


                                    if (id == 2) //IVA - EXENTO
                                    {
                                        UtilClass.EscribirArchivoLog("ID(2)" + id, _strLog, true);
                                        totalImpEx += baseImp;
                                    }

                                }

                                totalIVA += importe;
                                UtilClass.EscribirArchivoLog("totalIVA" + totalIVA, _strLog, true);

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
                            case "NO GRAVADO":
                                totalNoGrav += baseImp;

                                /*El importe neto en el comprobante debe ser el Neto Gravado: Al neto que trae el XML (Neto total) le resto el neto NO Gravado*/
                                comprobante.ImporteNeto -= totalNoGrav;

                                break;
                            case "EXENTO":
                                totalImpEx += baseImp;

                                break;
                            default:
                                break;
                        }


                    }

                    //comprobante.ImporteOpEx = Double.Parse((compXML.SelectSingleNode("//opexento").InnerText).Replace('.', ','));
                    
                    comprobante.ImporteTributo = totalTributo;
                    comprobante.ImporteIva = totalIVA;
                    comprobante.ImporteOpEx = totalImpEx;
                    comprobante.ImporteTotConc = totalNoGrav;
                    comprobante.ImporteTotal = Double.Parse((compXML.SelectSingleNode("//total").InnerText).Replace('.', ','));
                    comprobante.IDMoneda = compXML.SelectSingleNode("//idmoneda").InnerText;
                    comprobante.CanMisMonExt = compXML.SelectSingleNode("//mismonext").InnerText;
                    comprobante.CondicionIVAReceptorId = Int32.Parse(compXML.SelectSingleNode("//condivarid").InnerText); 
                    comprobante.CotizacionMoneda = Double.Parse((compXML.SelectSingleNode("//cotmoneda").InnerText).Replace('.', ','));
                    comprobante.Concepto = Int32.Parse(compXML.SelectSingleNode("//concepto").InnerText);
                    comprobante.Resultado = compXML.SelectSingleNode("//resultado").InnerText;
            

                    if (ubicacionAso != "")
                    {
                        List<string> listaRetorno = comprobante.CargarCompAsociados(ubicacionAso, cuitEmisor);

                        if (listaRetorno != null)
                        {

                            foreach (string cad in listaRetorno)
                            {
                                _error = true;
                                _errores.Add(cad);
                               
                            }


                        }
                    }
                   
                    string listaOpcioneales = compXML.SelectSingleNode("//opcionales").InnerText;
                 
                    comprobante.cargarOpcionales(listaOpcioneales);

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
        public bool CargaConfiguracionArchivo(string ubicacionArchivoConf)
        {
            bool retorno;
            _observaciones = new List<string>();
            _error = false;
            _errores = new List<string>();

            try
            {
                bool xmlCargado = CargaXMLConfiguracion(ubicacionArchivoConf);

                if (xmlCargado) // Cargo Archivo de LOG y demás propiedades
                {
                   /* //Cargar Archivo de LOG
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
                    */
                    _strPasswordSecureString = new SecureString();
                    _error = false;
                    _errores = new List<string>();
                    _ticketAcceso = null;
                    _ticketAccesoContrib = null;
                    _observaciones = new List<string>();
                    //   _gestionFE = new FEClass(_strServAFIP, _strCuit, _archivoLog, _flujoEscritura, _strLog);
                    _gestionFE = new FEClass(_strServAFIP, _strCuit,  _strLog);
                    _gestionContribuyente = new ContribuyenteClass(_strServContrib , _strCuit, _strLog);
                    // Cargo el ticket de Acceso

                    _ticketAcceso = _gestionFE.ObtenerTicketAcceso(_strTicketAcceso, _strIdServicioNegocio, _strUrlWsaaWsdl, _strRutaCertSigner, _strPasswordSecureString, _strProxy, _strProxyUser, _strProxyPassword);


                    // Cargo ticket de acceso para servicio de contribuyentes 
                    if (_strIdServicioPersona.Trim().Length == 0 || _strServContrib.Trim().Length == 0)
                    {
                        // No se carga el servicio de contribuyentes
                        _ticketAccesoContrib = null;
                        string mensaje = "Falta el Nombre del serivio para Constancia de Inscripción Contribuyente \n";

                        UtilClass.EscribirArchivoLog(mensaje, _strLog, true);

                    }
                    else
                    {
                        _ticketAccesoContrib = _gestionFE.ObtenerTicketAcceso(_strTicketAcceso + "_C", _strIdServicioPersona, _strUrlWsaaWsdl, _strRutaCertSigner, _strPasswordSecureString, _strProxy, _strProxyUser, _strProxyPassword);
                    }

                    _observaciones.AddRange(_gestionFE.ListaObservaciones);
                    if (_ticketAcceso != null)
                    {
                        string fecha_expiracion = _ticketAcceso.ExpirationTime.ToString();

                        string mensaje = "Ticket de Acceso obtenido para facturación Electrónica, válido hasta: " + fecha_expiracion + "\n";
                        //agregarObservaciones(mensaje, true);
                        //  UtilClass.EscribirArchivoLog(mensaje, _archivoLog, _flujoEscritura, _strLog, true);
                        UtilClass.EscribirArchivoLog(mensaje,  _strLog, true);
                        retorno = true;
                    }
                    else
                    {
                        string mensaje = "No se pudo obtener el Ticket de acceso para la facturación Electrónica\n";
                        //agregarObservaciones(mensaje, true);
                        //UtilClass.EscribirArchivoLog(mensaje, _archivoLog, _flujoEscritura, _strLog, true);
                        UtilClass.EscribirArchivoLog(mensaje, _strLog, true);
                        retorno = false;
                    }


                    if (_ticketAccesoContrib != null)
                    {
                        string fecha_expiracion = _ticketAccesoContrib.ExpirationTime.ToString();

                        string mensaje = "Ticket de Acceso obtenido, válido hasta: " + fecha_expiracion + "\n";
                        //agregarObservaciones(mensaje, true);
                        //  UtilClass.EscribirArchivoLog(mensaje, _archivoLog, _flujoEscritura, _strLog, true);
                        UtilClass.EscribirArchivoLog(mensaje, _strLog, true);
                        retorno = true;
                    }
                    else
                    {
                        string mensaje = "No se pudo obtener el Ticket de acceso del servicio Constancia de Inscripción Contribuyente\n";
                        //agregarObservaciones(mensaje, true);
                        //UtilClass.EscribirArchivoLog(mensaje, _archivoLog, _flujoEscritura, _strLog, true);
                        UtilClass.EscribirArchivoLog(mensaje, _strLog, true);
                        retorno = false;
                    }

                }
                else
                {
                    _strPasswordSecureString = null;
                   // _archivoLog = null;
                  //  _flujoEscritura = null;
                    _strPasswordSecureString = null;
                    _strLog = "";
                    _error = true;
                    _errores = new List<string>();
                    _errores.Add("No se pudo cargar el Archivo XML de Configuración");
                 
                    _ticketAcceso = null;
                    _observaciones = null;
                    _ticketAccesoContrib = null;
                    retorno = false;
                }
            }
            catch (Exception e)
            {
                AgregarObservaciones(e.Message, true);
                UtilClass.EscribirArchivoLog(e.Message, _strLog);
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
        public bool CargaConfiguracion(string servicio, string serv_urlwsaawsdl, string serv_afip, string proxy, string proxy_user, string proxy_pass, string certificado, string ticket_acceso, int intentos_aut, int intentos_ta, string nombre_empresa, string cuit_empresa, string log, string serv_contrib, string servicioper)
        {
            bool retorno = false;
            try
            {
                bool parametrosCargado = CargaConfiguracionParametros(servicio, serv_urlwsaawsdl, serv_afip, proxy, proxy_user, proxy_pass, certificado, ticket_acceso, intentos_aut, intentos_ta, nombre_empresa, cuit_empresa, log, serv_contrib, servicioper);

                if (parametrosCargado) // Cargo Archivo de LOG y demás propiedades
                {
                   /* //Cargar Archivo de LOG
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
                    */
                    _strPasswordSecureString = new SecureString();
                    _error = false;
                    _errores = new List<string>();
                    _ticketAcceso = null;
                    _ticketAccesoContrib = null;
                    _observaciones = new List<string>();

                    //  _gestionFE = new FEClass(_strServAFIP, _strCuit, _archivoLog, _flujoEscritura, _strLog);
                    _gestionFE = new FEClass(_strServAFIP, _strCuit, _strLog);
                    _gestionContribuyente = new ContribuyenteClass(_strServContrib, _strCuit, _strLog);

                    // Cargo el ticket de Acceso para servicio de facturación

                    _ticketAcceso = _gestionFE.ObtenerTicketAcceso(_strTicketAcceso, _strIdServicioNegocio, _strUrlWsaaWsdl, _strRutaCertSigner, _strPasswordSecureString, _strProxy, _strProxyUser, _strProxyPassword);
       
                    _observaciones.AddRange(_gestionFE.ListaObservaciones);
                    if (_ticketAcceso != null)
                    {
                        string fecha_expiracion = _ticketAcceso.ExpirationTime.ToString();

                        string mensaje = "Ticket de Acceso obtenido para facturación electrónica, válido hasta: " + fecha_expiracion + "\n";
                        //agregarObservaciones(mensaje, true);
                        //  UtilClass.EscribirArchivoLog(mensaje, _archivoLog, _flujoEscritura, _strLog, true);
                        UtilClass.EscribirArchivoLog(mensaje, _strLog, true);
                        retorno = true;
                    }
                    else
                    {
                        string mensaje = "No se pudo obtener el Ticket de acceso\n";
                        //agregarObservaciones(mensaje, true);
                        // UtilClass.EscribirArchivoLog(mensaje, _archivoLog, _flujoEscritura, _strLog, true);
                        UtilClass.EscribirArchivoLog(mensaje, _strLog, true);
                        retorno = false;
                    }


                    // Cargo ticket de acceso para servicio de contribuyentes 
                    if (_strIdServicioPersona.Trim().Length == 0 || _strServContrib.Trim().Length == 0)
                    {
                        // No se carga el servicio de contribuyentes
                        _ticketAccesoContrib = null;
                        string mensaje = "Falta el Nombre del serivio para Constancia de Inscripción Contribuyente  \n";
                      
                        UtilClass.EscribirArchivoLog(mensaje, _strLog, true);

                    }
                    else
                    {
                        _ticketAccesoContrib = _gestionFE.ObtenerTicketAcceso(_strTicketAcceso + "_C", _strIdServicioPersona, _strUrlWsaaWsdl, _strRutaCertSigner, _strPasswordSecureString, _strProxy, _strProxyUser, _strProxyPassword);

                        _observaciones.AddRange(_gestionFE.ListaObservaciones);
                        if (_ticketAccesoContrib != null)
                        {
                            string fecha_expiracion = _ticketAccesoContrib.ExpirationTime.ToString();

                            string mensaje = "Ticket de Acceso obtenido para constancia de inscripción Contribuyente, válido hasta: " + fecha_expiracion + "\n";
                            //agregarObservaciones(mensaje, true);
                            //  UtilClass.EscribirArchivoLog(mensaje, _archivoLog, _flujoEscritura, _strLog, true);
                            UtilClass.EscribirArchivoLog(mensaje, _strLog, true);
                            retorno = true;
                        }
                        else
                        {
                            string mensaje = "No se pudo obtener el Ticket de acceso para constancia de inscripción Contribuyente\n";
                            //agregarObservaciones(mensaje, true);
                            // UtilClass.EscribirArchivoLog(mensaje, _archivoLog, _flujoEscritura, _strLog, true);
                            UtilClass.EscribirArchivoLog(mensaje, _strLog, true);
                            retorno = false;
                        }
                    }

                    

                }
                else
                {
                    _strPasswordSecureString = null;
                   // _archivoLog = null;
                  //  _flujoEscritura = null;
                    _strPasswordSecureString = null;
                    _strLog = "";
                    _error = true;
                    _errores = new List<string>();
                    _errores.Add("No se pudo cargar el Archivo XML de Configuración");
                    _ticketAcceso = null;
                    _observaciones = null;
                    _ticketAccesoContrib = null;
                    UtilClass.EscribirArchivoLog("No se pudo cargar el Archivo XML de Configuración", _strLog);

                    retorno = false;
                }
            }
            catch (Exception e)
            {
                AgregarObservaciones(e.Message, true);
                UtilClass.EscribirArchivoLog(e.Message, _strLog);
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
        public bool ProbarServicio(int ptoVta, int tipoComp = 1)
        {

            bool r;

            try
            {
                r = _gestionFE.ProbarServicio(_ticketAcceso, ptoVta, tipoComp);
                _error = false;
                _errores = new List<string>();

            }
            catch (Exception e)
            {
                r = false;
                _error = true;
                _errores.Add(e.Message);
                UtilClass.EscribirArchivoLog(e.Message, _strLog);

            }

            return r;
        }


        /// <summary>
        /// Obtiene el último numero autorizado para ese tipo de comprobante
        /// </summary>
        /// <param name="ptoVta">Número de Tipo de punto de venta a usar</param>
        /// <returns>Retorno: El número de comprobante</returns>
        public int ObtenerUltNroComp(int ptoVta, int tipoComp = 1)
        {

            int utl_nro = 0;

            try
            {
                utl_nro = _gestionFE.UltimoNroComp(_ticketAcceso, ptoVta, tipoComp);
                _error = false;
                _errores = new List<string>();

            }
            catch (Exception e)
            {
                utl_nro = -1;
                _error = true;
                _errores.Add(e.Message);
                UtilClass.EscribirArchivoLog(e.Message, _strLog);

            }

            return utl_nro;
        }



        /// <summary>
        /// Autoriza el comprobante cuyos datos están en un xml ubicado en 'ubicadoComp' con el ID pasado como parámetro
        /// </summary>
        /// <param name="ubicacionComp">Ubicación del archivo XML con información del comprobante a autorizar y ubicacion del archivo con comprobantes asociados en caso que tenga</param>
        /// <param name="idRegistro">ID del registro a autorizar, debe coincidir con el ID registrado en el XML</param>
        /// <returns>Retorna True si no se generaron errores propios del modulo</returns>
        public bool AutorizarComp(string ubicacionCompAso, int idRegistro)
        {
            UtilClass.EscribirArchivoLog("AutorizarCOMP", _strLog);
            bool retorno;
            _observaciones = new List<string>();
            _error = false;
            _errores = new List<string>();
            try
            {
                if (ubicacionCompAso == null || ubicacionCompAso.Length == 0) // Nombre del Archivo de configuración incorrecto
                {
                    _error = true;
                    string mensaje = "El nombre del Archivo de configuración es incorrecto\n";
                    _errores.Add(mensaje);
                    UtilClass.EscribirArchivoLog(mensaje, _strLog);
                    retorno = false;
                }
                else
                {


                    UtilClass.EscribirArchivoLog("CARGA COMPROBANTE\n", _strLog);

                    ComprobanteClass comprobante = CargaComprobante(ubicacionCompAso, idRegistro,_strCuit);
                    UtilClass.EscribirArchivoLog("DESPUES COMPROBANTE\n", _strLog);
                    if (comprobante != null)
                    {
                       
                        ComprobanteClass comprobanteRespuesta = null;
                        UtilClass.EscribirArchivoLog("ANTES  AutorizarComprobante\n", _strLog);
                        comprobanteRespuesta = _gestionFE.AutorizarComprobante(_ticketAcceso, comprobante, idRegistro);
                        UtilClass.EscribirArchivoLog("DESUES  AutorizarComprobante\n", _strLog);
                        UtilClass.EscribirArchivoLog((_gestionFE.Observaciones)+"\n", _strLog);
                       
                        
                        if (comprobanteRespuesta != null)
                        {
                                                      
                            try
                            {

                                string[] ubicaciones = ubicacionCompAso.Split(';');


                                string ubicacionComp = "";
                                string ubicacionAso = "";

                                int cantUbi = ubicaciones.Length;
                                
                                switch (cantUbi)
                                {

                                    case 1:
                                        ubicacionComp = ubicaciones[0];
                                        ubicacionAso = "";
                                        break;
                                    case 2:
                                        ubicacionComp = ubicaciones[0];
                                        ubicacionAso = ubicaciones[1];
                                        break;
                                    default:


                                        _error = true;
                                        _errores.Add("El ID del registro pasado como parámetro no coincide con el ID registro del archivo XML");
                                        return false;
                                        break;
                                }

                                if (ubicacionComp == null || ubicacionComp.Length == 0)
                                {
                                    string mensaje = ("Ubicacion del comprobanteXML Vacia o nula");
                                    UtilClass.EscribirArchivoLog(mensaje, _strLog);
                               
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
                                    string mensaje = "Respuesta Obtenida: \n";
                                    mensaje += "\n Resultado: " + comprobanteRespuesta.Resultado;
                                    mensaje += "\n CESP - CAE: " + comprobanteRespuesta.CAE;
                                    mensaje += "\n Numero: " + comprobanteRespuesta.NroComprobante.ToString();
                                    mensaje += "\n Observaciones: "+ comprobanteRespuesta.ObservacionesAFIP;
                                    mensaje += "\n Errores: " + comprobanteRespuesta.ErroresAFIP;

                                    UtilClass.EscribirArchivoLog(mensaje, _strLog);
                                }
                            }
                            catch (Exception e)
                            {
                                _error = true;
                                string obs = _gestionFE.Observaciones;
                                string mensaje = "Ocurrio un error: " + e.Message +"\n OBS:"+obs; 
                                _errores.Add(mensaje);
                                
                                UtilClass.EscribirArchivoLog(mensaje, _strLog);
                                return false;
                            }


                            retorno = true;
                        }
                        else
                        {

                            UtilClass.EscribirArchivoLog("COMPROBANTE RESPUESTA NULL\n", _strLog);

                            retorno = false;
                        }

                    }
                    else
                    {
                        UtilClass.EscribirArchivoLog("COMPROBANTE NULL\n", _strLog);
                        retorno = false;
                    }

                }

            }
            catch (Exception e)
            {
                _error = true;
                string mensaje = "Ocurrio un error: " + e.Message;
                _errores.Add(mensaje);
                UtilClass.EscribirArchivoLog(mensaje, _strLog);
                return false;
            }

            return retorno;

        }

        /// <summary>
        /// Obtiene los datos del contribuyente retornandolos en el xml ubicado en 'ubicacionXMLContrib' con el ID pasado como parámetro
        /// </summary>
        /// <param name="ubicacionXMLContrib">Ubicación del archivo XML con información del comprobante a autorizar y ubicacion del archivo con comprobantes asociados en caso que tenga</param>
        /// <param name="cuitContrib">ID del registro a autorizar, debe coincidir con el ID registrado en el XML</param>
        /// <returns>Retorna True si no se generaron errores propios del modulo</returns>
        public bool ObtenerContribuyente(string ubicacionXMLContrib, string cuitContrib)
        {
            bool retorno;
            _observaciones = new List<string>();
            _error = false;
            _errores = new List<string>();
            try
            {
                if (ubicacionXMLContrib == null || ubicacionXMLContrib.Length == 0) // Nombre del Archivo XML incorrecto
                {
                    _error = true;
                    string mensaje = "El nombre del Archivo de respuesta 'obtenerContribuyente' es incorrecto";
                    _errores.Add(mensaje);
                    UtilClass.EscribirArchivoLog(mensaje, _strLog);
                    retorno = false;
                }
                else
                {

                  if (_ticketAccesoContrib == null)
                    {
                        _error = true;
                        string mensaje = "No se encuentra cargado el ticket de acceso para el servicio Constancia de Inscripción Contribuyentes \n";
                        _errores.Add(mensaje);
                        UtilClass.EscribirArchivoLog(mensaje, _strLog);
                        retorno = false;
                    }


                   bool obtuvoContrib = _gestionContribuyente.obtenerContribuyente(_ticketAccesoContrib, cuitContrib, ubicacionXMLContrib);

                    if(obtuvoContrib)
                    {

                        //ComprobanteClass comprobanteRespuesta = null;
                        //comprobanteRespuesta = _gestionFE.AutorizarComprobante(_ticketAcceso, comprobante, idRegistro);


                        //if (comprobanteRespuesta != null)
                        //{

                        //    //try
                        //    //{

                        //    //    string[] ubicaciones = ubicacionCompAso.Split(';');


                        //    //    string ubicacionComp = "";
                        //    //    string ubicacionAso = "";

                        //    //    int cantUbi = ubicaciones.Length;

                        //    //    switch (cantUbi)
                        //    //    {

                        //    //        case 1:
                        //    //            ubicacionComp = ubicaciones[0];
                        //    //            ubicacionAso = "";
                        //    //            break;
                        //    //        case 2:
                        //    //            ubicacionComp = ubicaciones[0];
                        //    //            ubicacionAso = ubicaciones[1];
                        //    //            break;
                        //    //        default:


                        //    //            _error = true;
                        //    //            _errores.Add("El ID del registro pasado como parámetro no coincide con el ID registro del archivo XML");
                        //    //            return false;
                        //    //            break;
                        //    //    }

                        //    //    if (ubicacionComp == null || ubicacionComp.Length == 0)
                        //    //    {
                        //    //        string mensaje = ("Ubicacion del comprobanteXML Vacia o nula");
                        //    //        UtilClass.EscribirArchivoLog(mensaje, _strLog);

                        //    //    }
                        //    //    else
                        //    //    {

                        //    //        XmlDocument comprobanteXML = new XmlDocument();

                        //    //        comprobanteXML.Load(ubicacionComp);

                        //    //        comprobanteXML.SelectSingleNode("//cespcae").InnerText = comprobanteRespuesta.CAE;
                        //    //        comprobanteXML.SelectSingleNode("//numero").InnerText = comprobanteRespuesta.NroComprobante.ToString();
                        //    //        comprobanteXML.SelectSingleNode("//caecespven").InnerText = comprobanteRespuesta.FechaVtoCAE;
                        //    //        comprobanteXML.SelectSingleNode("//resultado").InnerText = comprobanteRespuesta.Resultado;
                        //    //        comprobanteXML.SelectSingleNode("//observa").InnerText = comprobanteRespuesta.ObservacionesAFIP;
                        //    //        comprobanteXML.SelectSingleNode("//errores").InnerText = comprobanteRespuesta.ErroresAFIP;


                        //    //        comprobanteXML.Save(ubicacionComp);
                        //    //        string mensaje = "Respuesta Obtenida: \n";
                        //    //        mensaje += "\n Resultado: " + comprobanteRespuesta.Resultado;
                        //    //        mensaje += "\n CESP - CAE: " + comprobanteRespuesta.CAE;
                        //    //        mensaje += "\n Numero: " + comprobanteRespuesta.NroComprobante.ToString();
                        //    //        mensaje += "\n Observaciones: " + comprobanteRespuesta.ObservacionesAFIP;
                        //    //        mensaje += "\n Errores: " + comprobanteRespuesta.ErroresAFIP;

                        //    //        UtilClass.EscribirArchivoLog(mensaje, _strLog);
                        //    //    }
                        //    //}
                        //    //catch (Exception e)
                        //    //{
                        //    //    _error = true;
                        //    //    string mensaje = "Ocurrio un error: " + e.Message;
                        //    //    _errores.Add(mensaje);
                        //    //    UtilClass.EscribirArchivoLog(mensaje, _strLog);
                        //    //    return false;
                        //    //}


                        //    retorno = true;
                        //}
                        //else
                        //{

                        //    retorno = false;
                        //}

                        retorno = true;

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
                string mensaje = "Ocurrio un error: " + e.Message;
                _errores.Add(mensaje);
                UtilClass.EscribirArchivoLog(mensaje, _strLog);
                return false;
            }

            return retorno;

        }

        #endregion


        #endregion


    }
}
