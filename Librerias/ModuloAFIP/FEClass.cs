﻿using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Security;
using System.Xml;
using System.Reflection;
using System.Runtime.Remoting;
using EntidadesClass;
using System.Net;
using Microsoft.CSharp;
using System.CodeDom.Compiler;

namespace ModuloAFIP
{
    public class FEClass
    {

        #region Propiedades


        private bool _produccion;                                                       //Indica si se trabaja en modo producción
                                                                                        //   private string _nombreServicio; //Nombre del servicio utilizado
        private ClienteLoginCms_CS.ar.gov.afip.wswhomo.Service _servicioPrueba;         //Variable de acceso al servicio de prueba
        private ClienteLoginCms_CS.ar.gov.afip.servicios1.Service _servicioProduccion; //Variable de acceso al servicio de producción
                                                                                       //        private LoginTicket _ticketAcceso;                                              // Ticket de Acceso al servicio de AFIP
   //     private FileStream _archivoLog;                      //Variable para manejar el archivo de log
    //    private StreamWriter _flujoEscritura;                //Variable para manejar el flujo de escritura
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
        /// <param name="archLog">FileStream para manejar el archivo de log</param>
        /// <param name="flujoEsc">Flujo de escritura para el archivo de log</param>
        /// <param name="strLog">Nombre del archivo de log</param>
        /// <param name="produccion">Indica si el objeto creado de FEClass es de producción o prueba (utilizado para comprobar el servicio pasado)</param>

        public FEClass(ClienteLoginCms_CS.ar.gov.afip.wswhomo.Service servicioPru, string cuitEmisor, string strLog, bool produccion = false)
        {

            if (produccion)
            {
                // SI es producción
                _produccion = produccion;
                _servicioProduccion = null;
                _servicioPrueba = null;
                _cuitEmisor = "";
            //    _archivoLog = null;
            //    _flujoEscritura = null;
                _strLog = strLog;
                _configurado = false;
                _observaciones = new List<string>();
            }
            else
            {
                //NO es Producción
                _produccion = produccion;
                _cuitEmisor = cuitEmisor;
           //     _archivoLog = archLog;
           //     _flujoEscritura = flujoEsc;
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
        /// <param name="archLog">FileStream para manejar el archivo de log</param>
        /// <param name="flujoEsc">Flujo de escritura para el archivo de log</param>
        /// <param name="strLog">Nombre del archivo de log</param>
        /// <param name="produccion">Indica si el objeto creado de FEClass es de producción o prueba (utilizado para comprobar el servicio pasado)</param>
        public FEClass(ClienteLoginCms_CS.ar.gov.afip.servicios1.Service servicioPro, string cuitEmisor, string strLog, bool produccion = false)
        {

            if (produccion)
            {
                // SI es producción
                _produccion = produccion;
                _cuitEmisor = cuitEmisor;
                _servicioPrueba = null;
                _servicioProduccion = servicioPro;
//                _archivoLog = archLog;
       //         _flujoEscritura = flujoEsc;
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
           //     _archivoLog = null;
          //      _flujoEscritura = null;
                _strLog = strLog;
                _configurado = false;
                _observaciones = new List<string>();
            }

        }

        /// <summary>
        /// Constructor de la clase FEClass
        /// </summary>
        /// <param name="strServicioAfip">Nombre del servicio a utilizar, pudiendo ser:
        ///                                  ClienteLoginCms_CS.ar.gov.afip.servicios1.Service 
        ///                                  ClienteLoginCms_CS.ar.gov.afip.wswhomo.Service</param>
        /// <param name="cuitEmisor">CUIT de la empresa emisora del comprobante</param>
        /// <param name="archLog">Stream del </param>
        /// <param name="flujoEsc"></param>
        /// <param name="strLog"></param>
        public FEClass(string strServicioAfip, string cuitEmisor, string strLog)
        {

            try
            {
                if (strServicioAfip == "ClienteLoginCms_CS.ar.gov.afip.servicios1")
                {
                    _produccion = true;
                    _servicioProduccion = new ClienteLoginCms_CS.ar.gov.afip.servicios1.Service();
                    _servicioPrueba = null;
                }
                else
                {
                    _produccion = false;
                    _servicioProduccion = null;
                    _servicioPrueba = new ClienteLoginCms_CS.ar.gov.afip.wswhomo.Service();
                }

                _cuitEmisor = cuitEmisor;
             //   _archivoLog = archLog;
             //   _flujoEscritura = flujoEsc;
                _strLog = strLog;
                _configurado = true;
                _observaciones = new List<string>();
            }
            catch (Exception e)
            {

                _servicioProduccion = null;
                _servicioPrueba = null;
                _cuitEmisor = cuitEmisor;
          //      _archivoLog = archLog;
           //     _flujoEscritura = flujoEsc;
                _strLog = strLog;
                _configurado = false;
                _observaciones = new List<string>();
            }

        }
        #endregion

        #region Métodos

        #region Métodos Privados
        /// <summary>
        /// Método para comprobar que el servicio de AFIP de PRUEBA esté funcionando correctamente.
        /// Accede al servicio del AFIP con un Ticket de acceso y consulta por el último comprobante según el PtoVta y el TipoComp
        /// </summary>
        /// <param name="ticketAcceso">Ticket de Acceso al servicio AFIP</param>
        /// <param name="servicio">Servicio utilizado de AFIP, Para Prueba</param>
        /// <param name="ptoVta">Punto de Venta Registrado en el servicio AFIP</param>
        /// <param name="tipoComp">Tipo de comprobante para realizar la consulta</param>
        /// <returns>Retorna True, en caso de que el servicio Funcione correctamente; False o Excepción en otro caso</returns>
        private bool ProbarServicio(LoginTicket ticketAcceso, ClienteLoginCms_CS.ar.gov.afip.wswhomo.Service servicio, int ptoVta, int tipoComp = 1)
        {
            bool r;

            try
            {
                if (servicio != null)
                {
                    //Asigno los valores de autorización: CUIT, SIGN y Token
                    ClienteLoginCms_CS.ar.gov.afip.wswhomo.FEAuthRequest autorizacion = new ClienteLoginCms_CS.ar.gov.afip.wswhomo.FEAuthRequest();

                    string cuit = UtilClass.CambiarFormatoCuitSinGuiones(_cuitEmisor);
                    long cuitLong = 0;
                    if (long.TryParse(cuit, out cuitLong))
                    {
                        autorizacion.Cuit = cuitLong;
                        autorizacion.Sign = ticketAcceso.Sign;
                        autorizacion.Token = ticketAcceso.Token;
                    }
                    else
                    {
                        string mensaje = "";

                        mensaje = "Error al probar el servicio. \n No se pudo convertir el cuit: Compruebe el número de CUIT.\n";

                        //Escribo en el archivo

                        // UtilClass.EscribirArchivoLog(mensaje, _archivoLog, _flujoEscritura, _strLog);
                        UtilClass.EscribirArchivoLog(mensaje, _strLog, true);
                        Exception e = new Exception(mensaje);
                        throw e;

                    }
                    ClienteLoginCms_CS.ar.gov.afip.wswhomo.FERecuperaLastCbteResponse respuestaUltAut = null;
                    respuestaUltAut = servicio.FECompUltimoAutorizado(autorizacion, ptoVta, tipoComp);


                    if (respuestaUltAut != null && respuestaUltAut.Errors == null)
                    {
                        if (respuestaUltAut.CbteNro >= 0)
                        {
                            r = true;
                        }
                        else
                        {
                            Exception errorExc = new Exception("El número del último comprobante es negativo\n");
                            throw errorExc;
                        }
                    }
                    else
                    {
                        string mensaje = "";

                        mensaje = "Error al probar el servicio. \n No se pudo obtener el ultimo comprobante autorizado: Compruebe la configuración del Servicio de AFIP.\n";

                        //Escribo en el archivo

                        //UtilClass.EscribirArchivoLog(mensaje, _archivoLog, _flujoEscritura, _strLog);
                        UtilClass.EscribirArchivoLog(mensaje, _strLog, true);
                        Exception e = new Exception(mensaje);
                        throw e;

                    }
                }
                else
                {
                    string mensaje = "";

                    mensaje = "Error al probar el servicio. \n El servicio que se quiere utilizar es NULO: Compruebe la configuración del Servicio.\n";

                    //Escribo en el archivo

                    //UtilClass.EscribirArchivoLog(mensaje, _archivoLog, _flujoEscritura, _strLog);
                    UtilClass.EscribirArchivoLog(mensaje, _strLog, true);
                    Exception e = new Exception(mensaje);
                    throw e;
                }

            }
            catch (Exception e)
            {
                string mensaje = "";

                mensaje = "Error al probar el servicio de AFIP. " + e.Message + "\n";

                //Escribo en el archivo

                //UtilClass.EscribirArchivoLog(mensaje, _archivoLog, _flujoEscritura, _strLog);
                UtilClass.EscribirArchivoLog(mensaje, _strLog, true);
                Exception ex = new Exception(mensaje);
                throw ex;
            }

            return r;
        }


        /// <summary> 
        /// Método para comprobar que el servicio de AFIP de PRODUCCIÓN esté funcionando correctamente.
        /// Accede al servicio del AFIP con un Ticket de acceso y consulta por el último comprobante según el PtoVta y el TipoComp
        /// </summary>
        /// <param name="ticketAcceso">Ticket de Acceso al servicio AFIP</param>
        /// <param name="servicio">Servicio utilizado de AFIP, Para Producción</param>
        /// <param name="ptoVta">Punto de Venta Registrado en el servicio AFIP</param>
        /// <param name="tipoComp">Tipo de comprobante para realizar la consulta</param>
        /// <returns>Retorna True, en caso de que el servicio Funcione correctamente; False o Excepción en otro caso</returns>
        private bool ProbarServicio(LoginTicket ticketAcceso, ClienteLoginCms_CS.ar.gov.afip.servicios1.Service servicio, int ptoVta, int tipoComp = 1)
        {
            bool r;

            try
            {
                if (servicio != null)
                {
                    //Asigno los valores de autorización: CUIT, SIGN y Token
                    ClienteLoginCms_CS.ar.gov.afip.servicios1.FEAuthRequest autorizacion = new ClienteLoginCms_CS.ar.gov.afip.servicios1.FEAuthRequest();

                    string cuit = UtilClass.CambiarFormatoCuitSinGuiones(_cuitEmisor);
                    long cuitLong = 0;
                    if (long.TryParse(cuit, out cuitLong))
                    {
                        autorizacion.Cuit = cuitLong;
                        autorizacion.Sign = ticketAcceso.Sign;
                        autorizacion.Token = ticketAcceso.Token;
                    }
                    else
                    {
                        string mensaje = "";

                        mensaje = "Error al probar el servicio. \n No se pudo convertir el cuit: Compruebe el número de CUIT.\n";

                        //Escribo en el archivo

                        //UtilClass.EscribirArchivoLog(mensaje, _archivoLog, _flujoEscritura, _strLog);
                        UtilClass.EscribirArchivoLog(mensaje, _strLog, true);
                        Exception e = new Exception(mensaje);
                        throw e;

                    }
                    ClienteLoginCms_CS.ar.gov.afip.servicios1.FERecuperaLastCbteResponse respuestaUltAut = null;
                    respuestaUltAut = servicio.FECompUltimoAutorizado(autorizacion, ptoVta, tipoComp);


                    if (respuestaUltAut != null && respuestaUltAut.Errors == null)
                    {
                        if (respuestaUltAut.CbteNro >= 0)
                        {
                            r = true;
                        }
                        else
                        {
                            Exception errorExc = new Exception("El número del último comprobante es negativo\n");
                            throw errorExc;
                        }
                    }
                    else
                    {
                        string mensaje = "";

                        mensaje = "Error al probar el servicio. \n No se pudo obtener el ultimo comprobante autorizado: Compruebe la configuración del Servicio de AFIP.\n";

                        //Escribo en el archivo

                        // UtilClass.EscribirArchivoLog(mensaje, _archivoLog, _flujoEscritura, _strLog);
                        UtilClass.EscribirArchivoLog(mensaje, _strLog, true);
                        Exception e = new Exception(mensaje);
                        throw e;

                    }
                }
                else
                {
                    string mensaje = "";

                    mensaje = "Error al probar el servicio. \n El servicio que se quiere utilizar es NULO: Compruebe la configuración del Servicio.\n";

                    //Escribo en el archivo

                    //UtilClass.EscribirArchivoLog(mensaje, _archivoLog, _flujoEscritura, _strLog);
                    UtilClass.EscribirArchivoLog(mensaje, _strLog, true);
                    Exception e = new Exception(mensaje);
                    throw e;
                }

            }
            catch (Exception e)
            {

                string mensaje;

                mensaje = "Error al probar el servicio de AFIP. " + e.Message + "\n";

                //Escribo en el archivo

                //UtilClass.EscribirArchivoLog(mensaje, _archivoLog, _flujoEscritura, _strLog);
                UtilClass.EscribirArchivoLog(mensaje, _strLog, true);
                Exception ex = new Exception(mensaje);
                throw ex;

            }

            return r;
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
        /// Autoriza el comprobante de PRUEBA pasado como parametro con el Ticket de Acceso, el IdComprobante es para asegurar de que sea el comprobante que se pasa
        /// </summary>
        /// <param name="ticketAcceso">Ticket de Acceso utilizado para acceder a los servicios del AFIP</param>
        /// <param name="comprobante">Comprobante a Autorizar</param>
        /// <param name="idComprobante">ID del comprobante a autorizar</param>
        /// <returns>ComprobanteClass si se autorizó correctamente, NULL en otro caso</returns>
        private ComprobanteClass AutorizarComprobantePru(LoginTicket ticketAcceso, ComprobanteClass comprobante, int idComprobante)
        {
            UtilClass.EscribirArchivoLog("En AutorizarComprobantePru", _strLog, true);
            if (ticketAcceso != null && idComprobante > 0 && comprobante.IDComprobante > 0)
            {
                if (comprobante.IDComprobante == idComprobante)
                {
                    if (comprobante.CAE != "" || comprobante.CAE.Length > 0 || comprobante.Resultado == "A")
                    {
                        string inf;

                        inf = "Error al autorizar el comprobante por ID. El comprobante ya está autorizado con CAE: " + comprobante.CAE + "\n";
                      //  this.AgregarObservaciones(inf, true);
                        //Escribo en el archivo

                        //UtilClass.EscribirArchivoLog(inf, _archivoLog, _flujoEscritura, _strLog, true);
                        UtilClass.EscribirArchivoLog(inf, _strLog, true);
                        Exception errorExc = new Exception(inf);
                        throw errorExc;
                    }
                    else
                    {
                        try
                        {
                            //Asigno los valores de autorización: CUIT, SIGN y Token
                            ClienteLoginCms_CS.ar.gov.afip.wswhomo.FEAuthRequest autorizacionPru = new ClienteLoginCms_CS.ar.gov.afip.wswhomo.FEAuthRequest();

                            string cuit = UtilClass.CambiarFormatoCuitSinGuiones(_cuitEmisor);
                            long cuitLong = 0;
                            if (long.TryParse(cuit, out cuitLong))
                            {
                                autorizacionPru.Cuit = cuitLong;
                                autorizacionPru.Sign = ticketAcceso.Sign;
                                autorizacionPru.Token = ticketAcceso.Token;
                            }
                            else
                            {
                                Exception errorExc = new Exception("No se pudo convertir el cuit a Long");
                                throw errorExc;
                            }

                            /*** Armar RequerimientoAutorización*/
                            UtilClass.EscribirArchivoLog("Antes de ArmarRequerimientoAutorizacion PRUEBA", _strLog, true);
                           

                            ClienteLoginCms_CS.ar.gov.afip.wswhomo.FECAERequest reqAut = ArmarRequerimientoAutorizacion(autorizacionPru, comprobante);
                              UtilClass.EscribirArchivoLog("Despues de ArmarRequerimientoAutorizacion", _strLog, true);
                            
                            if (!_produccion)
                            {
                                  UtilClass.EscribirArchivoLog("NO es producciòn", _strLog, true);
                                
                                if (comprobante.CAE == "" && comprobante.FechaVtoCAE == "" && comprobante.Resultado != "A")
                                {

                                     UtilClass.EscribirArchivoLog("Antes de FECAESolicitar", _strLog, true);
                                   
                                    //Autorizar
                                    ClienteLoginCms_CS.ar.gov.afip.wswhomo.FECAEResponse respuesta = _servicioPrueba.FECAESolicitar(autorizacionPru, reqAut);
                                      UtilClass.EscribirArchivoLog("Despues de FECAESolicitar", _strLog, true);
                                   
                                    // Cargo en el comprobante los datos de la respuesta
                                    if (respuesta != null)
                                    {
                                        
                                     
                                        comprobante.cargarRespuesta(respuesta);
                                     
                                       
                                    }
                                }
                                else
                                {
                                    // Ya está autorizado
                                    Exception errorExc = new Exception("El comprobante ya se encuentra Autorizado");
                                    throw errorExc;
                                }
                            }
                        }
                        catch (Exception e)
                        {
                            string inf;

                            inf = "Error al autorizar el comprobante por ID. " + e.Message + "\n" +e.Source+"\n" +e.Data+"\n"+e.InnerException+"\n"+e.StackTrace+"\n"+e.TargetSite+"\n";
                            
                            //Escribo en el archivo

                            //UtilClass.EscribirArchivoLog(inf, _archivoLog, _flujoEscritura, _strLog, true);
                            UtilClass.EscribirArchivoLog(inf, _strLog, true);
                            Exception errorExc = new Exception(inf);
                            throw errorExc;
                        }
                    }

                }
                else
                {
                    string inf ;

                    inf = "Error al autorizar el comprobante por ID. El ID del comprobante no se corresponde con el que se desea autorizar\n";

                    //Escribo en el archivo

                    //UtilClass.EscribirArchivoLog(inf, _archivoLog, _flujoEscritura, _strLog, true);
                    UtilClass.EscribirArchivoLog(inf, _strLog, true);
                    Exception errorExc = new Exception(inf);
                    throw errorExc;
                }
            }
            else
            {

                string inf;

                inf = "Error al autorizar el comprobante por ID. El ticket de acceso es NULL o idComprobante <= 0\n";

                //Escribo en el archivo

                //UtilClass.EscribirArchivoLog(inf, _archivoLog, _flujoEscritura, _strLog, true);
                UtilClass.EscribirArchivoLog(inf, _strLog, true);
                Exception errorExc = new Exception(inf);
                throw errorExc;
            }

            return comprobante;
        }

        /// <summary>
        /// Obtiene el ultimo comprobante registrado en modo PRUEBA
        /// </summary>
        /// <param name="autorizacion">Autorización para acceder al servicio del AFIP</param>
        /// <param name="puntoVenta">Punto de venta de facturación</param>
        /// <param name="tipoComprobante">Tipo de comprobante</param>
        /// <returns>FEReCuperaLastCbteResponse, NULL en caso de error</returns>
        private ClienteLoginCms_CS.ar.gov.afip.wswhomo.FERecuperaLastCbteResponse ObtenerUltimoComprobanteRegistrado(ClienteLoginCms_CS.ar.gov.afip.wswhomo.FEAuthRequest autorizacion, int puntoVenta, int tipoComprobante)
        {
            ClienteLoginCms_CS.ar.gov.afip.wswhomo.FERecuperaLastCbteResponse ultimoComprobante = null;

            try
            {
                if (!_produccion)
                {
                    ultimoComprobante = _servicioPrueba.FECompUltimoAutorizado(autorizacion, puntoVenta, tipoComprobante);
                }
            }
            catch (Exception excepcionObtUltComprobante)
            {
                string inf;

                inf = "***EXCEPCION AL OBTENER EL ÚLTIMO COMPROBANTE: " + excepcionObtUltComprobante.Message + "\n";

                //Escribo en el archivo
                //UtilClass.EscribirArchivoLog(inf, _archivoLog, _flujoEscritura, _strLog, true);
                UtilClass.EscribirArchivoLog(inf, _strLog, true);
                return null;
            }

            return ultimoComprobante;
        }


        /// <summary>
        /// Obtiene el ultimo comprobante registrado en modo PRODUCCIÓN
        /// </summary>
        /// <param name="autorizacion">Autorización para acceder al servicio del AFIP</param>
        /// <param name="puntoVenta">Punto de venta de facturación</param>
        /// <param name="tipoComprobante">Tipo de comprobante</param>
        /// <returns>FEReCuperaLastCbteResponse, NULL en caso de error</returns>
        private ClienteLoginCms_CS.ar.gov.afip.servicios1.FERecuperaLastCbteResponse ObtenerUltimoComprobanteRegistrado(ClienteLoginCms_CS.ar.gov.afip.servicios1.FEAuthRequest autorizacion, int puntoVenta, int tipoComprobante)
        {
            ClienteLoginCms_CS.ar.gov.afip.servicios1.FERecuperaLastCbteResponse ultimoComprobante = null;

            try
            {
                if (_produccion)
                {
                    ultimoComprobante = _servicioProduccion.FECompUltimoAutorizado(autorizacion, puntoVenta, tipoComprobante);
                }
            }
            catch (Exception excepcionObtUltComprobante)
            {
                string inf;

                inf = "***EXCEPCION AL OBTENER EL ÚLTIMO COMPROBANTE: " + excepcionObtUltComprobante.Message + "\n";

                //Escribo en el archivo
                // UtilClass.EscribirArchivoLog(inf, _archivoLog, _flujoEscritura, _strLog, true);
                UtilClass.EscribirArchivoLog(inf, _strLog, true);
                return null;
            }

            return ultimoComprobante;
        }


        /// <summary>
        /// Arma el requerimiento para obtener el CAE con el servicio de Prueba
        /// </summary>
        /// <param name="autorizacion">Autorización</param>
        /// <param name="comprobante">Comprobante a autorizar</param>
        /// <returns>Retorna el Requerimiento, Null en caso de Error</returns>
        private ClienteLoginCms_CS.ar.gov.afip.wswhomo.FECAERequest ArmarRequerimientoAutorizacion(ClienteLoginCms_CS.ar.gov.afip.wswhomo.FEAuthRequest autorizacion, ComprobanteClass comprobante)
        {
            ClienteLoginCms_CS.ar.gov.afip.wswhomo.FECAERequest reqAut = new ClienteLoginCms_CS.ar.gov.afip.wswhomo.FECAERequest();
            try
            {
                int tipoComprobante = comprobante.TipoComprobante;
                int puntoVenta = comprobante.PtoVta;
                string cuit = comprobante.NroDocCliente;

                /*** Cabecera de la solicitud del comprobante ***/
                ClienteLoginCms_CS.ar.gov.afip.wswhomo.FECAECabRequest cabreq = new ClienteLoginCms_CS.ar.gov.afip.wswhomo.FECAECabRequest();
                int cantidadReg = 1; //Siempre se autoriza de a 1 elemento
                cabreq.CantReg = cantidadReg;

                cabreq.CbteTipo = tipoComprobante;
                cabreq.PtoVta = puntoVenta;

                reqAut.FeCabReq = cabreq;

                //OBTENGO EL NUMERO DEL ULTIMO COMPROBANTE REGISTRADO
                ClienteLoginCms_CS.ar.gov.afip.wswhomo.FERecuperaLastCbteResponse ultComprobante = null;
                ultComprobante = ObtenerUltimoComprobanteRegistrado(autorizacion, puntoVenta, tipoComprobante);
               
                if (ultComprobante == null)
                {
                    Exception e = new Exception("No se pudo obtener el último comprobante");

                    throw e;
                }
                int numUltComp = ultComprobante.CbteNro;
                int cbteTipoUltComp = ultComprobante.CbteTipo;

                /*** Detalle de la solicitud del comprobante ***/
                ClienteLoginCms_CS.ar.gov.afip.wswhomo.FECAEDetRequest detReq = new ClienteLoginCms_CS.ar.gov.afip.wswhomo.FECAEDetRequest();
                
                detReq.Concepto = 1; //1: Productos
                long v_docNro = 0;
                /*
                                if (comprobante.DocTipoCliente == 80)
                                {
                                    string cuitSinGuiones = UtilClass.CambiarFormatoCuitSinGuiones(comprobante.NroDocCliente);
                                    long.TryParse(cuitSinGuiones, out v_docNro);
                                }
                                else
                                {
                                    Exception e = new Exception("El tipo de documento del cliente no es CUIT (80). ");

                                    throw e;
                                }
                  */

                string inf = "DOC TIPO: " + comprobante.DocTipoCliente + "\n";
                UtilClass.EscribirArchivoLog(inf, _strLog, true);


                 inf = "Nro doc: " + comprobante.NroDocCliente + "\n";
                UtilClass.EscribirArchivoLog(inf, _strLog, true);
              
                if (comprobante.DocTipoCliente == 80)
                {
                    string cuitSinGuiones = UtilClass.CambiarFormatoCuitSinGuiones(comprobante.NroDocCliente);
                    long.TryParse(cuitSinGuiones, out v_docNro);
                    detReq.DocTipo = comprobante.DocTipoCliente;
                }
                else
                {
                    long.TryParse(comprobante.NroDocCliente, out v_docNro);
                    detReq.DocTipo = comprobante.DocTipoCliente;
                }

                inf = "Nro doc conv: " + v_docNro+"\n";
                UtilClass.EscribirArchivoLog(inf, _strLog, true);
                detReq.DocNro = v_docNro; //Nro documento
                // detReq.DocTipo = 80; //CUIT: documento tipo 80

                detReq.CbteDesde = numUltComp + 1; //Numero de ultimo comprobante + 1
                detReq.CbteHasta = numUltComp + 1; //Numero de ultimo comprobante + 1
                
                detReq.CbteFch = comprobante.FechaComprobante;



                /*Asigno los totales de los importes. Donde:
                 * <impTotal> = <impTotConc> + <impNeto> + <impOpEx> + <impTrib> + <impIva>
                 */
               
                double compImpTotal = comprobante.ImporteTotal;
                detReq.ImpTotal = Math.Round(compImpTotal, 2);

                double compImpTotConc = comprobante.ImporteTotConc; // importe total exento
                detReq.ImpTotConc = Math.Round(compImpTotConc, 2);

                double compImpNeto = comprobante.ImporteNeto;
                detReq.ImpNeto = Math.Round(compImpNeto, 2);

                double compImpOpEx = comprobante.ImporteOpEx; // importe total exento
                detReq.ImpOpEx = Math.Round(compImpOpEx, 2);

                double compImpIvaTot = comprobante.ImporteIva; // importe total del iva
                detReq.ImpIVA = Math.Round(compImpIvaTot, 2);
                
                inf = "ImpTotal: " + detReq.ImpTotal + "\n";
                UtilClass.EscribirArchivoLog(inf, _strLog, true);

                inf = "compImpTotConc: " + detReq.ImpTotConc + "\n";
                UtilClass.EscribirArchivoLog(inf, _strLog, true);

                inf = "ImpNeto: " + detReq.ImpNeto + "\n";
                UtilClass.EscribirArchivoLog(inf, _strLog, true);

                inf = "compImpOpEx: " + compImpOpEx + "\n";
                UtilClass.EscribirArchivoLog(inf, _strLog, true);

                inf = "compImpIvaTot: " + compImpIvaTot  + "\n";
                UtilClass.EscribirArchivoLog(inf, _strLog, true);


                /*   if (compImpIvaTot == 0)
                   {
                       double compImpTotConc = comprobante.ImporteNeto;
                       //detReq.ImpTotConc = comprobante.imp_neto;
                       detReq.ImpTotConc = Math.Round(compImpTotConc, 2);
                       detReq.ImpOpEx = 0;
                       detReq.ImpNeto = 0;
                   }
                   else
                   {
                       detReq.ImpIVA = compImpIvaTot;
                   }*/

           
                /*if (compImpIvaTot == 0)
                {
                    double compImpTotConc = comprobante.ImporteNeto;
                    //detReq.ImpTotConc = comprobante.imp_neto;
                    detReq.ImpTotConc = Math.Round(compImpTotConc, 2);
                    detReq.ImpOpEx = 0;
                    detReq.ImpNeto = 0;
                }
                else
                {
                    detReq.ImpIVA = compImpIvaTot;
                }*/

                detReq.FchServDesde = "";
                detReq.FchServHasta = "";
                //detReq.FchVtoPago = "";
                detReq.FchVtoPago = comprobante.FechaVtoPago;

                detReq.MonId = comprobante.IDMoneda;
               
                detReq.MonCotiz = comprobante.CotizacionMoneda;
                detReq.CondicionIVAReceptorId = comprobante.CondicionIVAReceptorId;
                detReq.MonCotizSpecified = true;
                if (comprobante.CanMisMonExt != "")
                {
                    detReq.CanMisMonExt = comprobante.CanMisMonExt;
                }

                /*
                 * 
                DateTime fechaAct = DateTime.Now;
                DateTime fechaLimite = new DateTime(2025, 4, 15);
                
                
                if(fechaAct >= fechaLimite)
                {
                    string codigo = @"
                                   detReq.CondicionIVAReceptorId = comprobante.CondicionIVAReceptorId;

                                if (comprobante.CanMisMonExt != """")
                                {
                                    detReq.CanMisMonExt = comprobante.CanMisMonExt;
                                }
                                ";

                    CSharpCodeProvider provider = new CSharpCodeProvider();
                    CompilerParameters parametros = new CompilerParameters
                    {
                        GenerateExecutable = true,
                        GenerateInMemory = true
                    };
                    parametros.ReferencedAssemblies.Add("System.dll");

                    CompilerResults resultados = provider.CompileAssemblyFromSource(parametros, codigo);

                    if (resultados.Errors.Count == 0)
                    {
                        Assembly ensamblado = resultados.CompiledAssembly;
                        MethodInfo metodo = ensamblado.EntryPoint;
                        metodo.Invoke(null, null);
                    }
                    else
                    {
                        foreach (CompilerError error in resultados.Errors)
                        {
                            Console.WriteLine($"Error: {error.ErrorText}");
                        }
                    }
                }
                
                */


                detReq.ImpTrib = comprobante.ImporteTributo;
                
                if (detReq.ImpTrib > 0)
                {
                    List<ClienteLoginCms_CS.ar.gov.afip.wswhomo.Tributo> listaTributo = new List<ClienteLoginCms_CS.ar.gov.afip.wswhomo.Tributo>();
                    ClienteLoginCms_CS.ar.gov.afip.wswhomo.Tributo tributo = null;
                    foreach (TributoComprobanteClass t in comprobante.ListaTributos)
                    {
                        tributo = new ClienteLoginCms_CS.ar.gov.afip.wswhomo.Tributo();

                        tributo.Id = 0;
                        tributo.Alic = 0;
                        tributo.BaseImp = 0;
                        tributo.Desc = "";
                        tributo.Importe = 0;

                        tributo.Id = (short)t.ID;
                        tributo.Alic = t.Alicuota;
                        tributo.BaseImp = t.BaseImponible;
                        tributo.Desc = t.Descripcion;
                        tributo.Importe = t.Importe;

                        if (tributo.Id > 0 && tributo.BaseImp > 0 && tributo.Importe > 0)
                        {
                            listaTributo.Add(tributo);
                        }
                        else
                        {
                            Exception e = new Exception("Los valores de los tributos son incorrectos");
                            throw e;
                        }

                    }

                    ClienteLoginCms_CS.ar.gov.afip.wswhomo.Tributo[] arrayTributos = listaTributo.ToArray();

                    detReq.Tributos = arrayTributos;
                    detReq.ImpTrib = detReq.ImpTrib;
                }
               
                if (detReq.ImpIVA >= 0)
                {
                    int cantElemIva = comprobante.ListaIva.Count();

                    inf = "cantElemIva: " + cantElemIva + "\n";
                    UtilClass.EscribirArchivoLog(inf, _strLog, true);

                    if (cantElemIva > 0)
                    {
                        List<ClienteLoginCms_CS.ar.gov.afip.wswhomo.AlicIva> listIva = new List<ClienteLoginCms_CS.ar.gov.afip.wswhomo.AlicIva>();

                        ClienteLoginCms_CS.ar.gov.afip.wswhomo.AlicIva aiva = null;

                   
                        foreach (AlicuotaIvaClass a in comprobante.ListaIva)
                        {
                            aiva = new ClienteLoginCms_CS.ar.gov.afip.wswhomo.AlicIva();
                            aiva.Id = 0;
                            aiva.BaseImp = 0;
                            aiva.Importe = 0;

                            aiva.Id = a.ID;
                            aiva.BaseImp = Math.Round(a.BaseImp, 2);    //CONTROLAR SI ESTO ESTÁ BIEN, COMPARANDOLO CON EL MODULO DEL AFIP HECHO
                            aiva.Importe = Math.Round(a.Importe, 2);

                            inf = "aiva.Id: " + aiva.Id + "; aiva.BaseImp: " + aiva.BaseImp + "; aiva.Importe: " + aiva.Importe + "\n";
                            UtilClass.EscribirArchivoLog(inf, _strLog, true);



                            /* if (aiva.Id > 0 && aiva.BaseImp > 0 && aiva.Importe > 0)
                             {
                                 listIva.Add(aiva);
                             }
                             else
                             {
                                 Exception e = new Exception("La alicuota de iva tiene un valor Incorrecto");
                                 throw e;
                             }*/


                            if (aiva.Id > 0)
                            {
                                listIva.Add(aiva);
                            }
                            else
                            {
                                Exception e = new Exception("La alicuota de iva tiene un valor Incorrecto");
                                throw e;
                            }
                        }

                        ClienteLoginCms_CS.ar.gov.afip.wswhomo.AlicIva[] arrayIva = listIva.ToArray();
                        detReq.Iva = arrayIva;
                    }
                   
                   
                }

                // Agrego comprobantes asociados
                if (comprobante.ListaCompAsociados.Count > 0)
                {
                    List<ClienteLoginCms_CS.ar.gov.afip.wswhomo.CbteAsoc> listaCompAso = new List<ClienteLoginCms_CS.ar.gov.afip.wswhomo.CbteAsoc>();
                    ClienteLoginCms_CS.ar.gov.afip.wswhomo.CbteAsoc compAso = null;
                    foreach (CompAsociadoClass c in comprobante.ListaCompAsociados)
                    {
                        compAso = new ClienteLoginCms_CS.ar.gov.afip.wswhomo.CbteAsoc();

                        compAso.Nro = c.NroComprobante;
                        compAso.PtoVta = c.PtoVta;
                        compAso.Tipo = c.TipoComprobante;
                        compAso.Cuit = c.CuitEmisor;
                        compAso.CbteFch = c.FechaComprobante;

                        

                        if (compAso.Nro > 0 && compAso.PtoVta > 0 && compAso.Tipo > 0)
                        {
                            listaCompAso.Add(compAso);
                        }
                       

                    }

                    ClienteLoginCms_CS.ar.gov.afip.wswhomo.CbteAsoc[] arrayCompAso = listaCompAso.ToArray();

                    detReq.CbtesAsoc = arrayCompAso;
              
                }

                // Agrego los items de los Opcionales

               
                if (comprobante.ListaOpcionales.Count > 0)
                {
                    
                    List<ClienteLoginCms_CS.ar.gov.afip.wswhomo.Opcional> listaOpcionales = new List<ClienteLoginCms_CS.ar.gov.afip.wswhomo.Opcional>();
                    ClienteLoginCms_CS.ar.gov.afip.wswhomo.Opcional op = null;
                    foreach (OpcionalComprobanteClass c in comprobante.ListaOpcionales)
                    {
                        op = new ClienteLoginCms_CS.ar.gov.afip.wswhomo.Opcional();

                        op.Id = c.IDOpcional;
                        op.Valor = c.Valor;




                        if ((op.Id.Trim()).Length > 0 && (op.Valor.Trim()).Length > 0)
                        {
                            inf = "op.Id: " + op.Id + ";  op.Valor: " + op.Valor + "\n";
                            UtilClass.EscribirArchivoLog(inf, _strLog, true);


                            listaOpcionales.Add(op);
                        }
                       

                    }

                    ClienteLoginCms_CS.ar.gov.afip.wswhomo.Opcional[] arrayOpcional = listaOpcionales.ToArray();

                    detReq.Opcionales = arrayOpcional;

                }

              
                List<ClienteLoginCms_CS.ar.gov.afip.wswhomo.FECAEDetRequest> listaDetalle = new List<ClienteLoginCms_CS.ar.gov.afip.wswhomo.FECAEDetRequest>();

                listaDetalle.Add(detReq);
               
                ClienteLoginCms_CS.ar.gov.afip.wswhomo.FECAEDetRequest[] arrayDetalle = listaDetalle.ToArray();
                reqAut.FeDetReq = arrayDetalle;

                UtilClass.EscribirArchivoLog("\n ANTES DE CORREGIR ImpTotal: " + reqAut.FeDetReq.First().ImpTotal, _strLog, true);



                reqAut = CorregirImpuestos(reqAut);


                ClienteLoginCms_CS.ar.gov.afip.wswhomo.AlicIva[] listaIva = reqAut.FeDetReq.First().Iva;
                UtilClass.EscribirArchivoLog("DESPUES DE CORREGIR \n", _strLog, true);

                if (listaIva != null && listaIva.Count() > 0)
                {
                    foreach (ClienteLoginCms_CS.ar.gov.afip.wswhomo.AlicIva i in listaIva)
                    {

                        double baseImp = i.BaseImp;
                        int id = i.Id;
                        double importe = i.Importe;

                        double razon = ObtenerRazonImpuesto(id);

                        razon = razon / 100.00;

                        UtilClass.EscribirArchivoLog("baseImp: " + baseImp, _strLog, true);
                        UtilClass.EscribirArchivoLog("importe: " + importe, _strLog, true);
                        UtilClass.EscribirArchivoLog("id: " + id, _strLog, true);


                    }

                    UtilClass.EscribirArchivoLog("ImpIVA: " + reqAut.FeDetReq.First().ImpIVA, _strLog, true);
                    UtilClass.EscribirArchivoLog("ImpNeto: " + reqAut.FeDetReq.First().ImpNeto, _strLog, true);
                    UtilClass.EscribirArchivoLog("ImpOpEx: " + reqAut.FeDetReq.First().ImpOpEx, _strLog, true);
                    UtilClass.EscribirArchivoLog("ImpTotal: " + reqAut.FeDetReq.First().ImpTotal, _strLog, true);
                    UtilClass.EscribirArchivoLog("ImpTrib: " + reqAut.FeDetReq.First().ImpTrib, _strLog, true);

                    foreach (AlicuotaIvaClass a in comprobante.ListaIva)
                    {

                        inf = "DESPUES DE CORREGIR:  a.ID: " + a.ID + "; a.BaseImp: " + a.BaseImp + "; a.Importe: " + a.Importe + "\n";
                        UtilClass.EscribirArchivoLog(inf, _strLog, true);

                    }
                }
               

            }
            catch (Exception e)
            {
                string inf = "";

                string fecha = DateTime.Now.ToString();

                inf = inf + "[" + fecha + "] ";

                inf = inf + "Error al armar el requerimiento de autorización. " + e.Message + "\n";

                //Escribo en el archivo

                // UtilClass.EscribirArchivoLog(inf, _archivoLog, _flujoEscritura, _strLog);
                UtilClass.EscribirArchivoLog(inf, _strLog, true);
                return null;
            }

            return reqAut;
        }


        /// <summary>
        /// Arma el requerimiento para obtener el CAE con el servicio de PRODUCCIÓN
        /// </summary>
        /// <param name="autorizacion">Autorización</param>
        /// <param name="comprobante">Comprobante a autorizar</param>
        /// <returns>Retorna el Requerimiento, Null en caso de Error</returns>
        private ClienteLoginCms_CS.ar.gov.afip.servicios1.FECAERequest ArmarRequerimientoAutorizacion(ClienteLoginCms_CS.ar.gov.afip.servicios1.FEAuthRequest autorizacion, ComprobanteClass comprobante)
        {
            ClienteLoginCms_CS.ar.gov.afip.servicios1.FECAERequest reqAut = new ClienteLoginCms_CS.ar.gov.afip.servicios1.FECAERequest();
            try
            {
                int tipoComprobante = comprobante.TipoComprobante;
                int puntoVenta = comprobante.PtoVta;
                string cuit = comprobante.NroDocCliente;

                /*** Cabecera de la solicitud del comprobante ***/
                        ClienteLoginCms_CS.ar.gov.afip.servicios1.FECAECabRequest cabreq = new ClienteLoginCms_CS.ar.gov.afip.servicios1.FECAECabRequest();
                int cantidadReg = 1; //Siempre se autoriza de a 1 elemento
                cabreq.CantReg = cantidadReg;

                cabreq.CbteTipo = tipoComprobante;
                cabreq.PtoVta = puntoVenta;

                reqAut.FeCabReq = cabreq;


                //OBTENGO EL NUMERO DEL ULTIMO COMPROBANTE REGISTRADO
                ClienteLoginCms_CS.ar.gov.afip.servicios1.FERecuperaLastCbteResponse ultComprobante = null;
                ultComprobante = ObtenerUltimoComprobanteRegistrado(autorizacion, puntoVenta, tipoComprobante);

                if (ultComprobante == null)
                {
                    Exception e = new Exception("No se pudo obtener el último comprobante");

                    throw e;
                }
                int numUltComp = ultComprobante.CbteNro;
                int cbteTipoUltComp = ultComprobante.CbteTipo;



                /*** Detalle de la solicitud del comprobante ***/
                ClienteLoginCms_CS.ar.gov.afip.servicios1.FECAEDetRequest detReq = new ClienteLoginCms_CS.ar.gov.afip.servicios1.FECAEDetRequest();

                
                detReq.Concepto = 1; //1: Productos
                long v_docNro = 0;
/*
                if (comprobante.DocTipoCliente == 80)
                {
                    string cuitSinGuiones = UtilClass.CambiarFormatoCuitSinGuiones(comprobante.NroDocCliente);
                    long.TryParse(cuitSinGuiones, out v_docNro);
                }
                else
                {
                    Exception e = new Exception("El tipo de documento del cliente no es CUIT (80). ");

                    throw e;
                }*/

                if (comprobante.DocTipoCliente == 80)
                {
                    string cuitSinGuiones = UtilClass.CambiarFormatoCuitSinGuiones(comprobante.NroDocCliente);
                    long.TryParse(cuitSinGuiones, out v_docNro);
                    detReq.DocTipo = comprobante.DocTipoCliente;
                }
                else
                {
                    long.TryParse(comprobante.NroDocCliente, out v_docNro);
                    detReq.DocTipo = comprobante.DocTipoCliente;
                }

                detReq.DocNro = v_docNro; //Nro documento
               // detReq.DocTipo = 80; //CUIT: documento tipo 80

                detReq.CbteDesde = numUltComp + 1; //Numero de ultimo comprobante + 1
                detReq.CbteHasta = numUltComp + 1; //Numero de ultimo comprobante + 1

                detReq.CbteFch = comprobante.FechaComprobante;

                /*detReq.ImpTotal = comprobante.ImporteTotal;
                 detReq.ImpTotal = Math.Round(detReq.ImpTotal, 2);

                 detReq.ImpNeto = comprobante.ImporteNeto;
                 detReq.ImpNeto = Math.Round(detReq.ImpNeto, 2);

                 double compImpIvaTot = comprobante.ImporteIva; // importe total del iva
                 compImpIvaTot = Math.Round(compImpIvaTot, 2);

                 detReq.ImpOpEx = 0;
                 detReq.ImpTotConc = 0;


                 double compImpOpEx = comprobante.ImporteOpEx; // importe total exento
                 compImpOpEx = Math.Round(compImpOpEx, 2);

                 double compImpTotConc = comprobante.ImporteTotConc; // importe total exento
                 compImpTotConc = Math.Round(compImpTotConc, 2);
                */

                double compImpTotal = comprobante.ImporteTotal;
                detReq.ImpTotal = Math.Round(compImpTotal, 2);

                double compImpTotConc = comprobante.ImporteTotConc; // importe total exento
                detReq.ImpTotConc = Math.Round(compImpTotConc, 2);

                double compImpNeto = comprobante.ImporteNeto;
                detReq.ImpNeto = Math.Round(compImpNeto, 2);

                double compImpOpEx = comprobante.ImporteOpEx; // importe total exento
                detReq.ImpOpEx = Math.Round(compImpOpEx, 2);

                double compImpIvaTot = comprobante.ImporteIva; // importe total del iva
                detReq.ImpIVA = Math.Round(compImpIvaTot, 2);


                /*
               if (compImpIvaTot == 0)
                {
                    double compImpTotConc = comprobante.ImporteNeto;
                    detReq.ImpTotConc = Math.Round(compImpTotConc, 2);
                    detReq.ImpOpEx = 0;
                    detReq.ImpNeto = 0;
                }
                else
                {
                    detReq.ImpIVA = compImpIvaTot;
                }
                */
                //detReq.ImpIVA = compImpIvaTot;

                detReq.FchServDesde = "";
                detReq.FchServHasta = "";
                // detReq.FchVtoPago = "";
                detReq.FchVtoPago = comprobante.FechaVtoPago;

                detReq.MonId = comprobante.IDMoneda;
              
                detReq.MonCotiz = comprobante.CotizacionMoneda;
                               

                /*
                 MODIFICAR este gragmento de código despues que se actualice el servicio web de afip
                 */
                DateTime fechaAct = DateTime.Now;
                DateTime fechaLimite = new DateTime(2025, 4, 15);
                
                
                if(fechaAct >= fechaLimite)
                {
                    detReq.CondicionIVAReceptorId = comprobante.CondicionIVAReceptorId;
                    detReq.MonCotizSpecified = true;
                    if (comprobante.CanMisMonExt != "")
                    {
                        detReq.CanMisMonExt = comprobante.CanMisMonExt;
                    }
                }
                
            

               
                

                detReq.ImpTrib = comprobante.ImporteTributo;

                if (detReq.ImpTrib > 0)
                {
                    List<ClienteLoginCms_CS.ar.gov.afip.servicios1.Tributo> listaTributo = new List<ClienteLoginCms_CS.ar.gov.afip.servicios1.Tributo>();
                    ClienteLoginCms_CS.ar.gov.afip.servicios1.Tributo tributo = null;
                    foreach (TributoComprobanteClass t in comprobante.ListaTributos)
                    {
                        tributo = new ClienteLoginCms_CS.ar.gov.afip.servicios1.Tributo();

                        tributo.Id = 0;
                        tributo.Alic = 0;
                        tributo.BaseImp = 0;
                        tributo.Desc = "";
                        tributo.Importe = 0;

                        tributo.Id = (short)t.ID;
                        tributo.Alic = t.Alicuota;
                        tributo.BaseImp = t.BaseImponible;
                        tributo.Desc = t.Descripcion;
                        tributo.Importe = t.Importe;

                        if (tributo.Id > 0 && tributo.BaseImp > 0 && tributo.Importe > 0)
                        {
                            listaTributo.Add(tributo);
                        }
                        else
                        {
                            Exception e = new Exception("Los valores de los tributos son incorrectos");
                            throw e;
                        }

                    }

                    ClienteLoginCms_CS.ar.gov.afip.servicios1.Tributo[] arrayTributos = listaTributo.ToArray();


                    detReq.Tributos = arrayTributos;
                    detReq.ImpTrib = detReq.ImpTrib;
                }


                if (detReq.ImpIVA >= 0)
                {
                    int cantElemIva = comprobante.ListaIva.Count();

                    if (cantElemIva > 0)
                    {
                        List<ClienteLoginCms_CS.ar.gov.afip.servicios1.AlicIva> listIva = new List<ClienteLoginCms_CS.ar.gov.afip.servicios1.AlicIva>();

                        ClienteLoginCms_CS.ar.gov.afip.servicios1.AlicIva aiva = null;
                        foreach (AlicuotaIvaClass a in comprobante.ListaIva)
                        {
                            aiva = new ClienteLoginCms_CS.ar.gov.afip.servicios1.AlicIva();
                            aiva.Id = 0;
                            aiva.BaseImp = 0;
                            aiva.Importe = 0;

                            aiva.Id = a.ID;
                            aiva.BaseImp = Math.Round(a.BaseImp, 2);    //CONTROLAR SI ESTO ESTÁ BIEN, COMPARANDOLO CON EL MODULO DEL AFIP HECHO
                            aiva.Importe = Math.Round(a.Importe, 2);

                            /* if (aiva.Id > 0 && aiva.BaseImp > 0 && aiva.Importe > 0)
                             {
                                 listIva.Add(aiva);
                             }
                             else
                             {
                                 Exception e = new Exception("La alicuota de iva tiene un valor Incorrecto");
                                 throw e;
                             }*/

                            if (aiva.Id > 0)
                            {
                                listIva.Add(aiva);
                            }
                            else
                            {
                                Exception e = new Exception("La alicuota de iva tiene un valor Incorrecto");
                                throw e;
                            }


                        }

                        ClienteLoginCms_CS.ar.gov.afip.servicios1.AlicIva[] arrayIva = listIva.ToArray();
                        detReq.Iva = arrayIva;
                    }
                       
                   

                }


                // Agrego comprobantes asociados
                if (comprobante.ListaCompAsociados.Count > 0)
                {
                    List<ClienteLoginCms_CS.ar.gov.afip.servicios1.CbteAsoc> listaCompAso = new List<ClienteLoginCms_CS.ar.gov.afip.servicios1.CbteAsoc>();
                    ClienteLoginCms_CS.ar.gov.afip.servicios1.CbteAsoc compAso = null;
                    foreach (CompAsociadoClass c in comprobante.ListaCompAsociados)
                    {
                        compAso = new ClienteLoginCms_CS.ar.gov.afip.servicios1.CbteAsoc();

                        compAso.Nro = c.NroComprobante;
                        compAso.PtoVta = c.PtoVta;
                        compAso.Tipo = c.TipoComprobante;
                        compAso.Cuit = c.CuitEmisor;
                        compAso.CbteFch = c.FechaComprobante;


                        if (compAso.Nro > 0 && compAso.PtoVta > 0 && compAso.Tipo > 0)
                        {
                            listaCompAso.Add(compAso);
                        }


                    }

                    ClienteLoginCms_CS.ar.gov.afip.servicios1.CbteAsoc[] arrayCompAso = listaCompAso.ToArray();

                    detReq.CbtesAsoc = arrayCompAso;

                }

                // Agrego los items de los Opcionales

                if (comprobante.ListaOpcionales.Count > 0)
                {
                    List<ClienteLoginCms_CS.ar.gov.afip.servicios1.Opcional> listaOpcionales = new List<ClienteLoginCms_CS.ar.gov.afip.servicios1.Opcional>();
                    ClienteLoginCms_CS.ar.gov.afip.servicios1.Opcional op= null;
                    foreach (OpcionalComprobanteClass c in comprobante.ListaOpcionales)
                    {
                        op = new ClienteLoginCms_CS.ar.gov.afip.servicios1.Opcional();

                        op.Id = c.IDOpcional;
                        op.Valor = c.Valor;
                        
                        if ((op.Id.Trim()).Length > 0 && (op.Valor.Trim()).Length > 0)
                        {
                            listaOpcionales.Add(op);
                        }


                    }

                    ClienteLoginCms_CS.ar.gov.afip.servicios1.Opcional[] arrayOpcional = listaOpcionales.ToArray();

                    detReq.Opcionales = arrayOpcional;

                }

                List<ClienteLoginCms_CS.ar.gov.afip.servicios1.FECAEDetRequest> listaDetalle = new List<ClienteLoginCms_CS.ar.gov.afip.servicios1.FECAEDetRequest>();

                listaDetalle.Add(detReq);
                ClienteLoginCms_CS.ar.gov.afip.servicios1.FECAEDetRequest[] arrayDetalle = listaDetalle.ToArray();
                reqAut.FeDetReq = arrayDetalle;

                reqAut = CorregirImpuestos(reqAut);

                
                
            }
            catch (Exception e)
            {
                string inf = "";

                string fecha = DateTime.Now.ToString();

                inf = inf + "[" + fecha + "] ";


                inf = inf + "Error al armar el requerimiento de autorización. " + e.Message + "\n";

                //Escribo en el archivo

                // UtilClass.EscribirArchivoLog(inf, _archivoLog, _flujoEscritura, _strLog);
                UtilClass.EscribirArchivoLog(inf, _strLog, true);
                return null;
            }

            return reqAut;
        }



        /// <summary>
        /// Autoriza el comprobante de PRODUCCIÖN pasado como parametro con el Ticket de Acceso, el IdComprobante es para asegurar de que sea el comprobante que se pasa
        /// </summary>
        /// <param name="ticketAcceso">Ticket de Acceso utilizado para acceder a los servicios del AFIP</param>
        /// <param name="comprobante">Comprobante a Autorizar</param>
        /// <param name="idComprobante">ID del comprobante a autorizar</param>
        /// <returns>ComprobanteClass si se autorizó correctamente, NULL en otro caso</returns>
        private ComprobanteClass AutorizarComprobantePro(LoginTicket ticketAcceso, ComprobanteClass comprobante, int idComprobante)
        {
            if (ticketAcceso != null && idComprobante > 0 && comprobante.IDComprobante > 0)
            {
                if (comprobante.IDComprobante == idComprobante)
                {
                    if (comprobante.CAE != "" || comprobante.CAE.Length > 0 || comprobante.Resultado == "A")
                    {
                        string inf;

                        inf = "Error al autorizar el comprobante por ID. El comprobante ya está autorizado con CAE: " + comprobante.CAE + "\n";

                        //Escribo en el archivo

                        //UtilClass.EscribirArchivoLog(inf, _archivoLog, _flujoEscritura, _strLog, true);
                        UtilClass.EscribirArchivoLog(inf, _strLog, true);
                        Exception errorExc = new Exception(inf);
                        throw errorExc;
                    }
                    else
                    {
                        try
                        {
                            //Asigno los valores de autorización: CUIT, SIGN y Token
                            ClienteLoginCms_CS.ar.gov.afip.servicios1.FEAuthRequest autorizacionPro = new ClienteLoginCms_CS.ar.gov.afip.servicios1.FEAuthRequest();

                            string cuit = UtilClass.CambiarFormatoCuitSinGuiones(_cuitEmisor);
                            long cuitLong = 0;
                            if (long.TryParse(cuit, out cuitLong))
                            {
                                autorizacionPro.Cuit = cuitLong;
                                autorizacionPro.Sign = ticketAcceso.Sign;
                                autorizacionPro.Token = ticketAcceso.Token;
                               
                            }
                            else
                            {
                                Exception errorExc = new Exception("No se pudo convertir el cuit a Long");
                                throw errorExc;
                            }

                            /*** Armar RequerimientoAutorización */

                            ClienteLoginCms_CS.ar.gov.afip.servicios1.FECAERequest reqAut = ArmarRequerimientoAutorizacion(autorizacionPro, comprobante);

                            if (_produccion)
                            {
                                if (comprobante.CAE == "" && comprobante.FechaVtoCAE == "" && comprobante.Resultado != "A")
                                {

                                   
                                    //Autorizar
                                    ClienteLoginCms_CS.ar.gov.afip.servicios1.FECAEResponse respuesta = _servicioProduccion.FECAESolicitar(autorizacionPro, reqAut);

                                    // Cargo en el comprobante los datos de la respuesta
                                    if (respuesta != null)
                                    {
                                        comprobante.cargarRespuesta(respuesta);
                                    }
                                }
                                else
                                {
                                    // Ya está autorizado
                                    Exception errorExc = new Exception("El comprobante ya se encuentra Autorizado");
                                    throw errorExc;
                                }

                            }

                        }
                        catch (Exception e)
                        {
                            string inf;

                            inf = "Error al autorizar el comprobante por ID. " + e.Message + "\n"+e.StackTrace + "\n" + e.TargetSite + "\n";

                            //Escribo en el archivo

                            //UtilClass.EscribirArchivoLog(inf, _archivoLog, _flujoEscritura, _strLog, true);
                            UtilClass.EscribirArchivoLog(inf, _strLog, true);
                            Exception errorExc = new Exception(inf);
                            throw errorExc;
                        }
                    }

                }
                else
                {


                    string inf ;

                    inf = "Error al autorizar el comprobante por ID. El ID del comprobante no se corresponde con el que se desea autorizar\n";

                    //Escribo en el archivo

                    //UtilClass.EscribirArchivoLog(inf, _archivoLog, _flujoEscritura, _strLog, true);
                    UtilClass.EscribirArchivoLog(inf, _strLog, true);
                    Exception errorExc = new Exception(inf);
                    throw errorExc;
                }
            }
            else
            {

                string inf ;

                inf = "Error al autorizar el comprobante por ID. El ticket de acceso es NULL o idComprobante <= 0\n";

                //Escribo en el archivo

                // UtilClass.EscribirArchivoLog(inf, _archivoLog, _flujoEscritura, _strLog, true);
                UtilClass.EscribirArchivoLog(inf, _strLog, true);
                Exception errorExc = new Exception(inf);
                throw errorExc;
            }

            return comprobante;
        }
        

        #endregion

        #region Métodos Públicos

        /// <summary>
        /// Obtiene el Ticket de Acceso
        ///     Si esta vigente lo otiene de la ubicación establecida
        ///     Si no esta vigente lo obtiene del Web Service de AFIP
        /// </summary>
        /// <param name="ubicacion_TA">Ubicación del archivo local</param>
        /// <param name="strIdServicioNegocio">servicio al que se desea acceder</param>
        /// <param name="strUrlWsaaWsdl">URL del WSAA</param>
        /// <param name="strRutaCertSigner">Ruta del certificado X509 (con clave privada) usado para firmar</param>
        /// <param name="strPasswordSecureString">Password del certificado X509 (con clave privada) usado para firmar</param>
        /// <param name="strProxy">IP:port del proxy</param>
        /// <param name="strProxyUser">Usuario del proxy</param>
        /// <param name="strProxyPassword">Password del proxy</param>
        /// <param name="blnVerboseMode">Nivel detallado de descripcion? true/false</param>
        /// <returns>Retorna el Ticket de Acceso en caso de error retorna Null</returns>
        public LoginTicket ObtenerTicketAcceso(string ubicacion_TA, string strIdServicioNegocio, string strUrlWsaaWsdl, string strRutaCertSigner, SecureString strPasswordSecureString, string strProxy, string strProxyUser, string strProxyPassword, bool blnVerboseMode = false)
        {
            LoginTicket objTicketRespuesta = null;
            string strTicketRespuesta;
            bool pedirTA = true;
            DateTime fechHoraActual = DateTime.Now;
            ServicePointManager.Expect100Continue = true;
            ServicePointManager.SecurityProtocol = SecurityProtocolType.Tls12;

            if (File.Exists(ubicacion_TA)) //Si existe, cargo el TA de la ubicación local
            {              
                try
                {
                    XmlDocument xmlTA = new XmlDocument();
                   
                    xmlTA.Load(ubicacion_TA);
                   
                    strTicketRespuesta = xmlTA.OuterXml;

                    objTicketRespuesta = new LoginTicket();

                    objTicketRespuesta.UniqueId = UInt32.Parse(xmlTA.SelectSingleNode("//uniqueId").InnerText);
                    objTicketRespuesta.GenerationTime = DateTime.Parse(xmlTA.SelectSingleNode("//generationTime").InnerText);
                    objTicketRespuesta.ExpirationTime = DateTime.Parse(xmlTA.SelectSingleNode("//expirationTime").InnerText);
                    objTicketRespuesta.Sign = xmlTA.SelectSingleNode("//sign").InnerText;
                    objTicketRespuesta.Token = xmlTA.SelectSingleNode("//token").InnerText;
                 
                }
                catch (Exception excepcionAlCargarTicket)
                {
                    try
                    {
                        string inf = "";

                        inf = inf + excepcionAlCargarTicket.Message + "\n";

                        //Escribo en el archivo
                        //  UtilClass.EscribirArchivoLog(inf, _archivoLog, _flujoEscritura, _strLog, true);
                        UtilClass.EscribirArchivoLog(inf, _strLog, true);
                    }
                    catch (Exception e)
                    {
                        return null;
                    }
                    return null;
                }
                             
                //Compruebo si el ticket de acceso está vigente
                if (objTicketRespuesta.GenerationTime <= fechHoraActual && fechHoraActual < objTicketRespuesta.ExpirationTime)
                {
                    //El ticket está vigente, lo retorno
                    pedirTA = false;
                    return objTicketRespuesta;
                }
                else
                {
                    //Se debe obtener un nuevo Ticket de acceso
                    pedirTA = true;
                }
               
            }
            else //Si No se encontró el ticket de acceso en la ubicación especificada, se debe obtener uno nuevo
            {
                
                pedirTA = true;
            }

            try
            {
                //Obtener el Ticket de Acceso del Web Service
                if (pedirTA)
                {           
                    
                    objTicketRespuesta = new LoginTicket();
               
                    strTicketRespuesta = objTicketRespuesta.ObtenerLoginTicketResponse(strIdServicioNegocio, strUrlWsaaWsdl, strRutaCertSigner, strPasswordSecureString, strProxy, strProxyUser, strProxyPassword, blnVerboseMode);
                 
                    //guardar Ticket

                    XmlDocument xmlTA = new XmlDocument();
                    if (strTicketRespuesta != null)
                    {
                        xmlTA.LoadXml(strTicketRespuesta);

                        xmlTA.Save(ubicacion_TA);

                        return objTicketRespuesta;
                    }
                    else
                    {
                        return null;
                    }

                }
            }
            catch (XmlException e)
            {
                try
                {
                    string inf = "";

                    string fecha = DateTime.Now.ToString();

                    inf = inf + "***EXCEPCION XML: " + e.Message;

                    //Escribo en el archivo

                    // UtilClass.EscribirArchivoLog(inf, _archivoLog, _flujoEscritura, _strLog, true);
                    UtilClass.EscribirArchivoLog(inf, _strLog, true);

                }
                catch (Exception ex)
                {
                    return null;
                }

                return null;
            }
            catch (Exception excepcionObtUltComprobante)
            {
                try
                {
                    string inf = "";

                    string fecha = DateTime.Now.ToString();

                    inf = inf + "***EXCEPCION AL CARGAR TICKET: " + excepcionObtUltComprobante.Message;
                   
                    //Escribo en el archivo
                    // UtilClass.EscribirArchivoLog(inf, _archivoLog, _flujoEscritura, _strLog, true);
                    UtilClass.EscribirArchivoLog(inf, _strLog, true);
                    AgregarObservaciones(inf, true);

                }
                catch (Exception ex)
                {
                    return null;
                }

                return null;
            }

            return objTicketRespuesta;
        }


        /// <summary>
        /// Prueba el servicio de AFIP
        /// </summary>
        /// <param name="ticketAcceso">Ticket de Acceso</param>
        /// <param name="ptoVta">Pto de Vta que se utiliza</param>
        /// <param name="tipoComp">Tipo de comprobante a probar ( por defecto es 1 {Factura A}) </param>
        /// <returns>True si se probó el servicio y funciona correctamente, False en otro caso</returns>
        public bool ProbarServicio(LoginTicket ticketAcceso, int ptoVta, int tipoComp = 1)
        {
            bool r;
            if (ticketAcceso != null) // Existe un ticket de acceso
            {
                try
                {
                    if (_produccion) // Modo Producción
                    {
                        r = ProbarServicio(ticketAcceso, _servicioProduccion, ptoVta, tipoComp);
                    }
                    else // Modo Prueba
                    {
                        r = ProbarServicio(ticketAcceso, _servicioPrueba, ptoVta, tipoComp);
                    }

                }
                catch (Exception e)
                {

                    string mensaje;

                    mensaje = "Error al probar el servicio de AFIP. " + e.Message + "\n";

                    //Escribo en el archivo

                    // UtilClass.EscribirArchivoLog(mensaje, _archivoLog, _flujoEscritura, _strLog);
                    UtilClass.EscribirArchivoLog(mensaje, _strLog, true);
                    //agregarObservaciones(mensaje, true);
                    Exception ex = new Exception(mensaje);
                    throw ex;
                }

            }
            else
            {
                string mensaje;

                mensaje = "Error al probar el servicio. \n El ticket de acceso es NULO: Compruebe la configuración del Ticket.\n";

                //Escribo en el archivo

                // UtilClass.EscribirArchivoLog(mensaje, _archivoLog, _flujoEscritura, _strLog);
                UtilClass.EscribirArchivoLog(mensaje, _strLog, true);
                //agregarObservaciones(mensaje, true);
                Exception e = new Exception(mensaje);
                throw e;
            }
            return r;
        }



        /// <summary>
        /// Prueba el servicio de AFIP
        /// </summary>
        /// <param name="ticketAcceso">Ticket de Acceso</param>
        /// <param name="ptoVta">Pto de Vta que se utiliza</param>
        /// <param name="tipoComp">Tipo de comprobante a probar ( por defecto es 1 {Factura A}) </param>
        /// <returns>Retorna el último numero de comproabnte</returns>
        public int UltimoNroComp(LoginTicket ticketAcceso, int ptoVta, int tipoComp = 1)
        {
           int ult_comp = -1;
            if (ticketAcceso != null) // Existe un ticket de acceso
            {
                try
                {
                    if (_produccion) // Modo Producción
                    {


                        ClienteLoginCms_CS.ar.gov.afip.servicios1.FERecuperaLastCbteResponse ultimoComprobante = null;
                        //Asigno los valores de autorización: CUIT, SIGN y Token
                        ClienteLoginCms_CS.ar.gov.afip.servicios1.FEAuthRequest autorizacionPro = new ClienteLoginCms_CS.ar.gov.afip.servicios1.FEAuthRequest();

                        string cuit = UtilClass.CambiarFormatoCuitSinGuiones(_cuitEmisor);
                        long cuitLong = 0;
                        if (long.TryParse(cuit, out cuitLong))
                        {
                            autorizacionPro.Cuit = cuitLong;
                            autorizacionPro.Sign = ticketAcceso.Sign;
                            autorizacionPro.Token = ticketAcceso.Token;
                        }
                        else
                        {
                            Exception errorExc = new Exception("No se pudo convertir el cuit a Long");
                            throw errorExc;
                        }


                        ultimoComprobante = ObtenerUltimoComprobanteRegistrado(autorizacionPro, ptoVta, tipoComp);


                        ult_comp = ultimoComprobante.CbteNro;

                        

                    }
                    else // Modo Prueba
                    {

                        ClienteLoginCms_CS.ar.gov.afip.wswhomo.FERecuperaLastCbteResponse ultimoComprobante = null;
                        //Asigno los valores de autorización: CUIT, SIGN y Token
                        ClienteLoginCms_CS.ar.gov.afip.wswhomo.FEAuthRequest autorizacionPru = new ClienteLoginCms_CS.ar.gov.afip.wswhomo.FEAuthRequest();

                        string cuit = UtilClass.CambiarFormatoCuitSinGuiones(_cuitEmisor);
                        long cuitLong = 0;
                        if (long.TryParse(cuit, out cuitLong))
                        {
                            autorizacionPru.Cuit = cuitLong;
                            autorizacionPru.Sign = ticketAcceso.Sign;
                            autorizacionPru.Token = ticketAcceso.Token;
                        }
                        else
                        {
                            Exception errorExc = new Exception("No se pudo convertir el cuit a Long");
                            throw errorExc;
                        }


                        ultimoComprobante = ObtenerUltimoComprobanteRegistrado(autorizacionPru,  ptoVta, tipoComp);


                        ult_comp = ultimoComprobante.CbteNro;
                    }

                }
                catch (Exception e)
                {

                    string mensaje;

                    mensaje = "Error al obtner el último numero de el servicio de AFIP. " + e.Message + "\n";

                    //Escribo en el archivo

                    // UtilClass.EscribirArchivoLog(mensaje, _archivoLog, _flujoEscritura, _strLog);
                    UtilClass.EscribirArchivoLog(mensaje, _strLog, true);
                    //agregarObservaciones(mensaje, true);
                    Exception ex = new Exception(mensaje);
                    throw ex;
                }

            }
            else
            {
                string mensaje;

                mensaje = "Error al obtener el útltimo numero autorizado. \n El ticket de acceso es NULO: Compruebe la configuración del Ticket.\n";

                //Escribo en el archivo

                // UtilClass.EscribirArchivoLog(mensaje, _archivoLog, _flujoEscritura, _strLog);
                UtilClass.EscribirArchivoLog(mensaje, _strLog, true);
                //agregarObservaciones(mensaje, true);
                Exception e = new Exception(mensaje);
                throw e;
            }
            return ult_comp;
        }


        /// <summary>
        /// Autoriza el comprobante que coincida con el ID del comprobante usando el ticket de acceso pasado como parámetro
        /// </summary>
        /// <param name="ticketAcceso">Ticket de Acceso usado para el servicio de AFIP</param>
        /// <param name="comprobante">Comprobante a autorizar</param>
        /// <param name="idComprobante">ID del comprobante a autorizar</param>
        /// <returns>Comprobante con datos actualizados obtenidos del AFIP (Puede estar Autorizado o Rechazado)</returns>
        public ComprobanteClass AutorizarComprobante(LoginTicket ticketAcceso, ComprobanteClass comprobante, int idComprobante)
        {
            try
            {
                if (_produccion)
                {

                    comprobante = AutorizarComprobantePro(ticketAcceso, comprobante, idComprobante);
                }
                else
                {
                    comprobante = AutorizarComprobantePru(ticketAcceso, comprobante, idComprobante);
                }

            }
            catch (Exception e)
            {
                string mensaje;

                mensaje = "Error al autorizar comprobante (ID " + idComprobante + "). " + e.Message;
                this.AgregarObservaciones(mensaje, true);
                Exception ex = new Exception(mensaje);
                throw ex;
            }
            return comprobante;
        }

        /// <summary>
        /// Función para corregir impuestos de iva
        /// </summary>
        /// <param name="reqAut">Requerimiento del afip a corregir</param>
        /// <returns>Retorna el requerimiento corregido</returns>
        private ClienteLoginCms_CS.ar.gov.afip.wswhomo.FECAERequest CorregirImpuestos(ClienteLoginCms_CS.ar.gov.afip.wswhomo.FECAERequest reqAut)
        {

            double totalIva = reqAut.FeDetReq.First().ImpIVA;
            double totalNeto = reqAut.FeDetReq.First().ImpNeto;
            double totalOpEx = reqAut.FeDetReq.First().ImpOpEx;
            double total = reqAut.FeDetReq.First().ImpTotal;
            double totalCon = reqAut.FeDetReq.First().ImpTotConc;
            double totalImpTrib = reqAut.FeDetReq.First().ImpTrib;



            UtilClass.EscribirArchivoLog("VALORES ANTES DE CORRECCIONES\n", _strLog, true);
            UtilClass.EscribirArchivoLog("ImpIVA: " + reqAut.FeDetReq.First().ImpIVA, _strLog, true);
            UtilClass.EscribirArchivoLog("ImpNeto: " + reqAut.FeDetReq.First().ImpNeto, _strLog, true);
            UtilClass.EscribirArchivoLog("ImpOpEx: " + reqAut.FeDetReq.First().ImpOpEx, _strLog, true);
            UtilClass.EscribirArchivoLog("ImpTotConc: " + reqAut.FeDetReq.First().ImpTotConc, _strLog, true);
            UtilClass.EscribirArchivoLog("ImpTrib: " + reqAut.FeDetReq.First().ImpTrib, _strLog, true);
            UtilClass.EscribirArchivoLog("ImpTotal: " + reqAut.FeDetReq.First().ImpTotal, _strLog, true);

     

            ClienteLoginCms_CS.ar.gov.afip.wswhomo.AlicIva[] listaIva = reqAut.FeDetReq.First().Iva;
            UtilClass.EscribirArchivoLog("Despues de obtener lista Iva\n", _strLog, true);
            double nuevoTotalIVA = 0.00;

            double nuevoNetoIVA = 0.00;

            if (listaIva != null)
            {
                int cantLista = listaIva.Count();


                UtilClass.EscribirArchivoLog("ANtes de IF cant lista\n", _strLog, true);
                if (cantLista > 0)
                {
                    
                    UtilClass.EscribirArchivoLog("CantLista > 0\n", _strLog, true);
                    // Corrijo los valores de impuestos
                    foreach (ClienteLoginCms_CS.ar.gov.afip.wswhomo.AlicIva i in listaIva)
                    {

                        double baseImp = i.BaseImp;
                        int id = i.Id;
                        double importe = i.Importe;

                        if (id != 1 && id != 2) // SI ES DISTINTO DE IVA-NO GRAVADO e IVA-EXENTO calculo
                        {
                            double razon = ObtenerRazonImpuesto(id);

                            razon = razon / 100.00;

                            UtilClass.EscribirArchivoLog("BaseImp Ant: " + baseImp, _strLog, true);
                            UtilClass.EscribirArchivoLog("importe Ant: " + importe, _strLog, true);

                            if (razon >= 0)
                            {


                                double totalImpuesto = baseImp + importe;

                                double nuevoNeto = Math.Round((totalImpuesto / (1 + razon)), 2);
                                double nuevoImpuesto = Math.Round((totalImpuesto - nuevoNeto), 2);

                                i.BaseImp = nuevoNeto;
                                i.Importe = nuevoImpuesto;

                                UtilClass.EscribirArchivoLog("BaseImp Nue: " + nuevoNeto, _strLog, true);
                                UtilClass.EscribirArchivoLog("importe Nue: " + nuevoImpuesto, _strLog, true);

                                nuevoTotalIVA += nuevoImpuesto;
                                nuevoNetoIVA += nuevoNeto;

                            }
                        }
                        



                    }
                }

            }



            UtilClass.EscribirArchivoLog("nuevoTotalIVA: " + nuevoTotalIVA, _strLog, true);
            UtilClass.EscribirArchivoLog("nuevoNetoIVA: " + nuevoNetoIVA, _strLog, true);

            // Corrijo totales
            reqAut.FeDetReq.First().ImpIVA = Math.Round(nuevoTotalIVA, 2);
            reqAut.FeDetReq.First().ImpNeto = Math.Round(nuevoNetoIVA, 2);

            /*     double nuevoTotal = 0.00;
             if (totalCon > 0)
             {
                 //reqAut.FeDetReq.First().ImpNeto = 0.00;
                  nuevoTotal = (reqAut.FeDetReq.First().ImpIVA) + (reqAut.FeDetReq.First().ImpOpEx) + (reqAut.FeDetReq.First().ImpTotConc) + (reqAut.FeDetReq.First().ImpTrib);
             }
             else
             {
                  nuevoTotal = (reqAut.FeDetReq.First().ImpIVA) + (reqAut.FeDetReq.First().ImpNeto) + (reqAut.FeDetReq.First().ImpOpEx) + (reqAut.FeDetReq.First().ImpTrib);
             }

             */




            UtilClass.EscribirArchivoLog("VALORES DESPUES DE CORRECCIONES\n", _strLog, true);
            UtilClass.EscribirArchivoLog("ImpIVA: " + reqAut.FeDetReq.First().ImpIVA, _strLog, true);
            UtilClass.EscribirArchivoLog("ImpNeto: " + reqAut.FeDetReq.First().ImpNeto, _strLog, true);
            UtilClass.EscribirArchivoLog("ImpOpEx: " + reqAut.FeDetReq.First().ImpOpEx, _strLog, true);
            UtilClass.EscribirArchivoLog("ImpTotConc: " + reqAut.FeDetReq.First().ImpTotConc, _strLog, true);
            UtilClass.EscribirArchivoLog("ImpTrib: " + reqAut.FeDetReq.First().ImpTrib, _strLog, true);
          

            double nuevoTotal = (reqAut.FeDetReq.First().ImpIVA) + (reqAut.FeDetReq.First().ImpNeto) + (reqAut.FeDetReq.First().ImpOpEx) + (reqAut.FeDetReq.First().ImpTotConc) + (reqAut.FeDetReq.First().ImpTrib);

            reqAut.FeDetReq.First().ImpTotal = Math.Round(nuevoTotal, 2);
            UtilClass.EscribirArchivoLog("ImpTotal: " + reqAut.FeDetReq.First().ImpTotal, _strLog, true);
        
            
            return reqAut;
        }



        /// <summary>
        /// Función para corregir impuestos de iva
        /// </summary>
        /// <param name="reqAut">Requerimiento del afip a corregir</param>
        /// <returns>Retorna el requerimiento corregido</returns>
        private ClienteLoginCms_CS.ar.gov.afip.servicios1.FECAERequest CorregirImpuestos(ClienteLoginCms_CS.ar.gov.afip.servicios1.FECAERequest reqAut)
        {

            double totalIva = reqAut.FeDetReq.First().ImpIVA;
            double totalNeto = reqAut.FeDetReq.First().ImpNeto;
            double totalOpEx = reqAut.FeDetReq.First().ImpOpEx;
            double total = reqAut.FeDetReq.First().ImpTotal;
            double totalCon = reqAut.FeDetReq.First().ImpTotConc;
            double totalImpTrib = reqAut.FeDetReq.First().ImpTrib;
            ClienteLoginCms_CS.ar.gov.afip.servicios1.AlicIva[] listaIva = reqAut.FeDetReq.First().Iva;


            double nuevoTotalIVA = 0.00;

            double nuevoNetoIVA = 0.00;

            if (listaIva != null)
            {
                int cantLista = listaIva.Count();

                if (cantLista > 0)
                {
                    // Corrijo los valores de impuestos
                    foreach (ClienteLoginCms_CS.ar.gov.afip.servicios1.AlicIva i in listaIva)
                    {

                        double baseImp = i.BaseImp;
                        int id = i.Id;
                        double importe = i.Importe;

                        double razon = ObtenerRazonImpuesto(id);

                        razon = razon / 100.00;


                        if (razon >= 0)
                        {


                            double totalImpuesto = baseImp + importe;

                            double nuevoNeto = Math.Round((totalImpuesto / (1 + razon)), 2);
                            double nuevoImpuesto = Math.Round((totalImpuesto - nuevoNeto), 2);

                            i.BaseImp = nuevoNeto;
                            i.Importe = nuevoImpuesto;


                            nuevoTotalIVA += nuevoImpuesto;
                            nuevoNetoIVA += nuevoNeto;

                        }

                    }
                }
            }
               


            // Corrijo totales
            reqAut.FeDetReq.First().ImpIVA = Math.Round(nuevoTotalIVA, 2);
            reqAut.FeDetReq.First().ImpNeto = Math.Round(nuevoNetoIVA, 2);

            double nuevoTotal = (reqAut.FeDetReq.First().ImpIVA) + (reqAut.FeDetReq.First().ImpNeto) + (reqAut.FeDetReq.First().ImpOpEx) + (reqAut.FeDetReq.First().ImpTotConc) + (reqAut.FeDetReq.First().ImpTrib);
            reqAut.FeDetReq.First().ImpTotal = Math.Round(nuevoTotal, 2);

            return reqAut;
        }

        /// <summary>
        /// Obtiene la razón del impuesto cuyo ID es pasado como parámetro
        /// </summary>
        /// <param name="idImpuesto">ID del impuesto</param>
        /// <returns>Retorna razón del impuesto</returns>
        private double ObtenerRazonImpuesto(int idImpuesto)
        {
            double razon = 0.00;
            switch (idImpuesto)
            {
                case 1:
                    razon = 0.00;
                    return 0.00;
                    break;
                case 2:
                    razon = 0.00d;
                    return 0.00;
                    break;
                case 3:
                    razon = 0.00;
                    return 0.00;
                    break;
                case 4:
                    razon = 10.50;
                    return 10.50;
                    break;
                case 5:
                    razon = 21.00;
                    return 21.00;
                    break;
                case 6:
                    razon = 27.00;
                    return 27.00;
                    break;
                default:
                    razon = -1;
                    return -1;
                    break;
            }
            return razon;
        }

    }


       
        #endregion

        #endregion


    }

