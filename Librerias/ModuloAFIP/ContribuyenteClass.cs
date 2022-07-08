using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Xml;
using System.Xml.Serialization;
using ClienteLoginCms_CS.ar.gov.afip;

namespace ModuloAFIP
{
    public class ContribuyenteClass
    {

        #region Propiedades


            private bool _produccion;                                                       //Indica si se trabaja en modo producción
                                                                                            //   private string _nombreServicio; //Nombre del servicio utilizado
            private ClienteLoginCms_CS.ar.gov.afip.personawshomo.PersonaServiceA5 _servicioPrueba; //Variable de acceso al servicio de prueba
            private ClienteLoginCms_CS.ar.gov.afip.personaws.PersonaServiceA5 _servicioProduccion; //Variable de acceso al servicio de producción
                                                                          
            private string _cuitEmisor;
            private string _strLog;
            private bool _configurado;                           // Variable que indica si se configuró correctamente el objeto de la clase FEClass
            private List<string> _observaciones;                    // Lista de observaciones
      

            /// <summary>
            /// Propiedad que indica si se cargó correctamente la configuración
            /// </summary>
            public bool Configurado
            {
                get { return _configurado; }
            }

            /// <summary>
            /// Propiedad que indica si se está trabajando en MODO PRODUCCIÓN
            /// </summary>
            public bool Produccion
            {
                get { return _produccion; }
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




        #region Constructor
        /// <summary>
        /// Constructor de la clase FEClass, usada para administrar los Comprobantes Electrónicos de PRUEBA
        /// </summary>
        /// <param name="servicioPru">Servicio de Prueba del AFIP</param>
        /// <param name="cuitEmisor">CUIT del emisor del comprobante</param>
        /// <param name="strLog">Nombre del archivo de log</param>
        /// <param name="produccion">Indica si el objeto creado de FEClass es de producción o prueba (utilizado para comprobar el servicio pasado)</param>

        public ContribuyenteClass(ClienteLoginCms_CS.ar.gov.afip.personawshomo.PersonaServiceA5 servicioPru, string cuitEmisor, string strLog, bool produccion = false)
        {

            if (produccion)
            {
                // SI es producción
                _produccion = produccion;
                _servicioProduccion = null;
                _servicioPrueba = null;
                _cuitEmisor = "";
                _strLog = strLog;
                _configurado = false;
                _observaciones = new List<string>();
            }
            else
            {
                //NO es Producción
                _produccion = produccion;
                _cuitEmisor = cuitEmisor;
                _strLog = strLog;
                _servicioPrueba = servicioPru;
                _servicioProduccion = null;
                _configurado = true;
                _observaciones = new List<string>();
            }

        }


        /// <summary>
        /// Constructor de la clase FEClass, usada para administrar los Comprobantes Electrónicos de PRODUCCIÓN
        /// </summary>
        /// <param name="servicioPro">Servicio de Producción del AFIP</param>
        /// <param name="cuitEmisor">CUIT del emisor del comprobante</param>
        /// <param name="strLog">Nombre del archivo de log</param>
        /// <param name="produccion">Indica si el objeto creado de FEClass es de producción o prueba (utilizado para comprobar el servicio pasado)</param>
        public ContribuyenteClass(ClienteLoginCms_CS.ar.gov.afip.personaws.PersonaServiceA5 servicioPro, string cuitEmisor, string strLog, bool produccion = false)
        {

            if (produccion)
            {
                // SI es producción
                _produccion = produccion;
                _cuitEmisor = cuitEmisor;
                _servicioPrueba = null;
                _servicioProduccion = servicioPro;
                _strLog = strLog;
                _configurado = true;
                _observaciones = new List<string>();
            }
            else
            {
                //NO es Producción
                _produccion = produccion;
                _servicioProduccion = null;
                _servicioPrueba = null;
                _cuitEmisor = "";
                _strLog = strLog;
                _configurado = false;
                _observaciones = new List<string>();
            }

        }

        /// <summary>
        /// Constructor de la clase FEClass
        /// </summary>
        /// <param name="strServicioAfip">Nombre del servicio a utilizar, pudiendo ser:
        ///                                  ClienteLoginCms_CS.ar.gov.afip.personaws.PersonaServiceA5 
        ///                                  ClienteLoginCms_CS.ar.gov.afip.personawshomo.PersonaServiceA5</param>
        /// <param name="cuitEmisor">CUIT de la empresa emisora del comprobante</param>
        /// <param name="archLog">Stream del </param>
        /// <param name="flujoEsc"></param>
        /// <param name="strLog"></param>
        public ContribuyenteClass(string strServContrib, string cuitEmisor, string strLog)
        {

            try
            {
                if (strServContrib == "ClienteLoginCms_CS.ar.gov.afip.personaws")
                {
                    _produccion = true;
                    _servicioProduccion = new ClienteLoginCms_CS.ar.gov.afip.personaws.PersonaServiceA5();
                    _servicioPrueba = null;
                }
                else
                {
                    _produccion = false;
                    _servicioProduccion = null;
                    _servicioPrueba = new ClienteLoginCms_CS.ar.gov.afip.personawshomo.PersonaServiceA5();
                }

                _cuitEmisor = cuitEmisor;
                _strLog = strLog;
                _configurado = true;
                _observaciones = new List<string>();
            }
            catch (Exception e)
            {

                _servicioProduccion = null;
                _servicioPrueba = null;
                _cuitEmisor = cuitEmisor;
                _strLog = strLog;
                _configurado = false;
                _observaciones = new List<string>();
            }

        }
        #endregion




        #region Métodos

            #region Métodos Privados
           


       
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


        #endregion


        #region Metodos Publicos

            /// <summary>
            /// Método para comprobar que el servicio de AFIP de PRUEBA esté funcionando correctamente.
            /// Accede al servicio del AFIP con un Ticket de acceso y consulta por el último comprobante según el PtoVta y el TipoComp
            /// </summary>
            /// <param name="ticketAcceso">Ticket de Acceso al servicio AFIP</param>
            /// <param name="servicio">Servicio utilizado de AFIP, Para Prueba</param>
            /// <param name="ptoVta">Punto de Venta Registrado en el servicio AFIP</param>
            /// <param name="tipoComp">Tipo de comprobante para realizar la consulta</param>
            /// <returns>Retorna True, en caso de que el servicio Funcione correctamente; False o Excepción en otro caso</returns>
            public bool ProbarServicio()
            {
                bool r = false ;

                try
                {
                    if (_configurado)
                    {
                        if (_produccion) // Pruebo servicio de poducción
                        {

                            ClienteLoginCms_CS.ar.gov.afip.personaws.dummyReturn respuesta = _servicioProduccion.dummy();
                            string appserver = respuesta.appserver;
                            string authserver = respuesta.authserver;
                            string dbserver = respuesta.dbserver;

                            if (appserver == "OK" && authserver == "OK" && dbserver == "OK")
                            {
                                r = true;
                            }
                            else
                            {
                                string mensaje = "Error al probar el servicio: ClienteLoginCms_CS.ar.gov.afip.personaws. \n appserver: " + appserver + "\n authserver: " + authserver + "\n dbserver: " + dbserver + "\n";

                                //Escribo en el archivo
                                UtilClass.EscribirArchivoLog(mensaje, _strLog, true);
                                Exception e = new Exception(mensaje);
                                throw e;
                            }
                        }
                        else
                        {

                            ClienteLoginCms_CS.ar.gov.afip.personawshomo.dummyReturn respuesta = _servicioPrueba.dummy();
                            string appserver = respuesta.appserver;
                            string authserver = respuesta.authserver;
                            string dbserver = respuesta.dbserver;

                            if (appserver == "OK" && authserver == "OK" && dbserver == "OK")
                            {
                                r = true;
                            }
                            else
                            {
                                string mensaje = "Error al probar el servicio: ClienteLoginCms_CS.ar.gov.afip.personawshomo. \n appserver: " + appserver + "\n authserver: " + authserver + "\n dbserver: " + dbserver + "\n";

                                //Escribo en el archivo
                                UtilClass.EscribirArchivoLog(mensaje, _strLog, true);
                                Exception e = new Exception(mensaje);
                                throw e;
                            }
                        }

                    }
                    else
                    {
                        string mensaje = "El servicio NO está configurado correctamente.";

                        //Escribo en el archivo
                        UtilClass.EscribirArchivoLog(mensaje, _strLog, true);
                        Exception e = new Exception(mensaje);
                        throw e;
                    }

                }
                catch (Exception e)
                {
                    string mensaje = "Error al probar el servicio de AFIP: " + e.Message + "\n";

                    //Escribo en el archivo
                    UtilClass.EscribirArchivoLog(mensaje, _strLog, true);
                    Exception ex = new Exception(mensaje);
                    throw ex;
                }

                return r;
            }


             /// <summary>
             /// Función que retorna el contribuyente según el cuit pasado como parámetro
             /// </summary>
             /// <param name="ticket">Ticket de acceso al servicio</param>
             /// <param name="cuitContrib">CUIT del contribuyente a buscar</param>
             /// <returns></returns>
            public ClienteLoginCms_CS.ar.gov.afip.personawshomo.personaReturn obtenerContribuyentePru(LoginTicket ticket, string cuitContrib)
            {
                long.TryParse(cuitContrib, out long cuitContriblg);
                long.TryParse(_cuitEmisor, out long cuitEmisorlg);
            UtilClass.EscribirArchivoLog("obt.cuitcontriblg: "+cuitContriblg, _strLog);
            UtilClass.EscribirArchivoLog("obt.cuitemisorlg: " + cuitEmisorlg, _strLog);
            try
                {
                if (!_produccion)
                {
                    ClienteLoginCms_CS.ar.gov.afip.personawshomo.personaReturn contribuyente = _servicioPrueba.getPersona(ticket.Token, ticket.Sign, cuitEmisorlg, cuitContriblg);

                    if (contribuyente != null)
                    {
                        return contribuyente;
                    }
                    else
                    {
                        string mensaje = "Respuesta de 'getPersona' nula.";

                        //Escribo en el archivo
                        UtilClass.EscribirArchivoLog(mensaje, _strLog, true);
                        Exception e = new Exception(mensaje);
                        throw e;
                    }
                }
                else
                {
                    string mensaje = "Módulo mal configurado. Se quiere obtener contribuyente en modo PRUEBA. pero está configurado en PRODUCCIÓN";

                    //Escribo en el archivo
                    UtilClass.EscribirArchivoLog(mensaje, _strLog, true);
                    Exception e = new Exception(mensaje);
                    throw e;
                }
                    
                
                }
                catch (Exception e)
                {
                    string mensaje = "Error al obtener el contribuyente: " + e.Message + "\n";

                    //Escribo en el archivo
                    UtilClass.EscribirArchivoLog(mensaje, _strLog, true);
                    Exception ex = new Exception(mensaje);
                    throw ex;
                }
                

            }

        public bool obtenerContribuyente(LoginTicket ticket, string cuitContrib, string ubicacionComp)
        {
            bool r = false;

            try
            {

                if (_produccion)
                {
                    ClienteLoginCms_CS.ar.gov.afip.personaws.personaReturn contribuyente = obtenerContribuyentePro(ticket, cuitContrib);

                 
                    string contribstr = "";


                    XmlSerializer serializer = new XmlSerializer(typeof(ClienteLoginCms_CS.ar.gov.afip.personaws.personaReturn));
                    using (var sww = new StringWriter())
                    {
                        using (XmlWriter writer = XmlWriter.Create(sww))
                        {
                            serializer.Serialize(writer, contribuyente);
                            contribstr = sww.ToString(); // Your XML
                        }
                    }




                    //   UtilClass.EscribirArchivoLog(contribxml, _strLog);

                    XmlDocument contribXML = new XmlDocument();
                    if (contribstr != null && contribstr.Length > 0)
                    {
                        contribXML.LoadXml(contribstr);

                        contribXML.Save(ubicacionComp);
                        r = true;
                    }
                    else
                    {
                        r = false;
                    }

                    //apellido = contribuyente.datosGenerales.apellido;
                    //contribuyente.datosGenerales.caracterizacion;
                    //contribuyente.datosGenerales.dependencia.;
                    //contribuyente.datosGenerales.domicilioFiscal.codPostal;
                    //contribuyente.datosGenerales.domicilioFiscal.datoAdicional;
                    //contribuyente.datosGenerales.domicilioFiscal.descripcionProvincia;
                    //contribuyente.datosGenerales.domicilioFiscal.direccion;
                    //contribuyente.datosGenerales.domicilioFiscal.idProvincia;
                    //contribuyente.datosGenerales.domicilioFiscal.localidad;
                    //contribuyente.datosGenerales.domicilioFiscal.tipoDatoAdicional;
                    //contribuyente.datosGenerales.domicilioFiscal.tipoDomicilio;


                }
                else
                {


                    UtilClass.EscribirArchivoLog("CUIT-CONTRIB:"+cuitContrib, _strLog);


                    ClienteLoginCms_CS.ar.gov.afip.personawshomo.personaReturn contribuyente = obtenerContribuyentePru(ticket, cuitContrib);

                    string contribstr = "";


                   XmlSerializer serializer = new XmlSerializer(typeof(ClienteLoginCms_CS.ar.gov.afip.personawshomo.personaReturn));
                    using (var sww = new StringWriter())
                    {
                        using (XmlWriter writer = XmlWriter.Create(sww))
                        {
                            serializer.Serialize(writer, contribuyente);
                            contribstr = sww.ToString(); // Your XML
                        }
                    }




                    //   UtilClass.EscribirArchivoLog(contribxml, _strLog);

                    XmlDocument contribXML = new XmlDocument();
                    if (contribstr != null && contribstr.Length > 0)
                    {
                        contribXML.LoadXml(contribstr);

                        contribXML.Save(ubicacionComp);
                        r = true;
                    }
                    else
                    {
                        r = false;
                    }


                }




                //XmlDocument comprobanteXML = new XmlDocument();

                //comprobanteXML.l
                //comprobanteXML.Load(ubicacionComp);

                //comprobanteXML.SelectSingleNode("//cespcae").InnerText = comprobanteRespuesta.CAE;
                //comprobanteXML.SelectSingleNode("//numero").InnerText = comprobanteRespuesta.NroComprobante.ToString();
                //comprobanteXML.SelectSingleNode("//caecespven").InnerText = comprobanteRespuesta.FechaVtoCAE;
                //comprobanteXML.SelectSingleNode("//resultado").InnerText = comprobanteRespuesta.Resultado;
                //comprobanteXML.SelectSingleNode("//observa").InnerText = comprobanteRespuesta.ObservacionesAFIP;
                //comprobanteXML.SelectSingleNode("//errores").InnerText = comprobanteRespuesta.ErroresAFIP;


                //comprobanteXML.Save(ubicacionComp);
                //string mensaje = "Respuesta Obtenida: \n";
                //mensaje += "\n Resultado: " + comprobanteRespuesta.Resultado;
                //mensaje += "\n CESP - CAE: " + comprobanteRespuesta.CAE;
                //mensaje += "\n Numero: " + comprobanteRespuesta.NroComprobante.ToString();
                //mensaje += "\n Observaciones: " + comprobanteRespuesta.ObservacionesAFIP;
                //mensaje += "\n Errores: " + comprobanteRespuesta.ErroresAFIP;

                //UtilClass.EscribirArchivoLog(mensaje, _strLog);


            }
            catch (Exception e)
            {
                r = false;
            }
            

                return r;
        }




        /// <summary>
        /// Función que retorna el contribuyente según el cuit pasado como parámetro
        /// </summary>
        /// <param name="ticket">Ticket de acceso al servicio</param>
        /// <param name="cuitContrib">CUIT del contribuyente a buscar</param>
        /// <returns></returns>
        public ClienteLoginCms_CS.ar.gov.afip.personaws.personaReturn obtenerContribuyentePro(LoginTicket ticket, string cuitContrib)
        {
            long.TryParse(cuitContrib, out long cuitContriblg);
            long.TryParse(_cuitEmisor, out long cuitEmisorlg);

            try
            {
                if(_produccion)
                {
                    ClienteLoginCms_CS.ar.gov.afip.personaws.personaReturn contribuyente = _servicioProduccion.getPersona(ticket.Token, ticket.Sign, cuitEmisorlg, cuitContriblg);

                    if (contribuyente != null)
                    {
                        return contribuyente;
                    }
                    else
                    {
                        string mensaje = "Respuesta de 'getPersona' nula.";

                        //Escribo en el archivo
                        UtilClass.EscribirArchivoLog(mensaje, _strLog, true);
                        Exception e = new Exception(mensaje);
                        throw e;
                    }
                }
                else
                {
                    string mensaje = "Módulo mal configurado. Se quiere obtener contribuyente en modo PRODUCCIÓN . pero está configurado en PRUEBA";

                    //Escribo en el archivo
                    UtilClass.EscribirArchivoLog(mensaje, _strLog, true);
                    Exception e = new Exception(mensaje);
                    throw e;
                }
                
            }
            catch (Exception e)
            {
                string mensaje = "Error al obtener el contribuyente: " + e.Message + "\n";

                //Escribo en el archivo
                UtilClass.EscribirArchivoLog(mensaje, _strLog, true);
                Exception ex = new Exception(mensaje);
                throw ex;
            }


        }




        #endregion
        #endregion
    }
}
