using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Xml;


namespace EntidadesClass
{


    public class ComprobanteClass
    {

        #region Propiedades
        private int _idComprobante;
        private int _ptoVta;
        private int _tipoComprobante;
        private int _docTipoEmpresa;
        private string _nroDocEmpresa;
        private int _docTipoCliente;
        private string _nroDocCliente;
        private long _nroComprobante;
        private string _fechaComprobante;
        private Double _importeTotal;
        private Double _importeNeto;
        private Double _importeOpEx;
        private Double _importeTrib;
        private Double _importeIva;
        private Double _importeTotConc;
        private string _idMoneda;
        private Double _cotizacionMoneda;
        private List<AlicuotaIvaClass> _listaIva;
        private List<TributoComprobanteClass> _listaTributos;
        private string _resultado;
        private string _reproceso;
        private string _fechaProceso;
        private int _concepto;
        private string _cae;
        private string _fechaVtoCae;
        private string _fechaVtoPago;
        private List<CompAsociadoClass> _listaCompAsociados;
        private List<string> _erroresAFIP;
        private List<string> _eventosAFIP;
        private List<string> _observacionesAFIP;
        private List<OpcionalComprobanteClass> _listaOpciones;
        private int _condicionIVAReceptorId;
        private string _canMisMonExt;




        /// <summary>
        /// Retorna y asigna el Id del comprobante
        /// </summary>
        public int IDComprobante
        {
            get { return _idComprobante; }
            set { _idComprobante = value; }
        }

        /// <summary>
        /// Retorna y asigna el Punto de Venta
        /// </summary>
        public int PtoVta
        {
            get { return _ptoVta; }

            set { _ptoVta = value; }
        }

        /// <summary>
        /// Retorna y asigna el Tipo de Comprobante
        /// </summary>
        public int TipoComprobante
        {
            get { return _tipoComprobante; }
            set { _tipoComprobante = value; }
        }

        /// <summary>
        /// Retorna y asigna el Tipo de Documento de la Empresa
        /// </summary>
        public int DocTipoEmpresa
        {
            get { return _docTipoEmpresa; }
            set { _docTipoEmpresa = value; }
        }

        /// <summary>
        /// Retorna y asigna el Número de Documento de la Empresa
        /// </summary>
        public string NroDocEmpresa
        {
            get { return _nroDocEmpresa; }
            set { _nroDocEmpresa = value; }
        }

        /// <summary>
        /// Retorna y asigna el Tipo de Documento del Cliente
        /// </summary>
        public int DocTipoCliente
        {
            get { return _docTipoCliente; }
            set { _docTipoCliente = value; }
        }

        /// <summary>
        /// Retorna y asigna el Número de Documento del cliente
        /// </summary>

        public string NroDocCliente
        {
            get { return _nroDocCliente; }
            set { _nroDocCliente = value; }
        }

        /// <summary>
        /// Retorna y asigna el Número del Comprobante
        /// </summary>
        public long NroComprobante
        {
            get { return _nroComprobante; }
            set { _nroComprobante = value; }
        }

        /// <summary>
        /// Retorna y asigna la Fecha del Comprobante
        /// </summary>
        public string FechaComprobante
        {
            get { return _fechaComprobante; }
            set { _fechaComprobante = value; }
        }

        /// <summary>
        /// Retorna y asigna el Importe Total
        /// </summary>
        public Double ImporteTotal
        {
            get { return _importeTotal; }
            set { _importeTotal = value; }
        }

        /// <summary>
        /// Retorna y asigna el Importe Neto
        /// </summary>
        public Double ImporteNeto
        {
            get { return _importeNeto; }
            set { _importeNeto = value; }
        }

        /// <summary>
        /// Retorna y asigna el Importe Op. Ex.
        /// </summary>
        public Double ImporteOpEx
        {
            get { return _importeOpEx; }
            set { _importeOpEx = value; }
        }

        /// <summary>
        /// Retorna y asigna el Importe No Gravado
        /// </summary>
        public Double ImporteTotConc
        {
            get { return _importeTotConc; }
            set { _importeTotConc = value; }
        }

        /// <summary>
        /// Retorna y asigna el Importe del Tributo
        /// </summary>
        public Double ImporteTributo
        {
            get { return _importeTrib; }
            set { _importeTrib = value; }
        }

        /// <summary>
        /// Retorna y asigna el Importe Iva
        /// </summary>
        public Double ImporteIva
        {
            get { return _importeIva; }
            set { _importeIva = value; }
        }

        /// <summary>
        /// Retorna y asigna el ID de la moneda utilizada
        /// </summary>
        public string IDMoneda
        {
            get { return _idMoneda; }
            set { _idMoneda = value; }
        }

        /// <summary>
        /// Retorna y asigna la cotización de la moneda
        /// </summary>
        public Double CotizacionMoneda
        {
            get { return _cotizacionMoneda; }
            set { _cotizacionMoneda = value; }
        }


        /// <summary>
        /// Retorna y asigna la Lista de Alicuotas de Iva
        /// </summary>
        public List<AlicuotaIvaClass> ListaIva
        {
            get { return _listaIva; }
            set { _listaIva = value; }
        }

        /// <summary>
        /// Retorna y asigna la lista de Tributos
        /// </summary>
        public List<TributoComprobanteClass> ListaTributos
        {
            get { return _listaTributos; }
            set { _listaTributos = value; }
        }

        /// <summary>
        /// Retorna y asigna el Resultado de la operación
        /// </summary>
        public string Resultado
        {
            get { return _resultado; }
            set { _resultado = value; }
        }

        /// <summary>
        /// Retorna y asigna el Reproceso
        /// </summary>
        public string Reproceso
        {
            get { return _reproceso; }
            set { _reproceso = value; }
        }

        /// <summary>
        /// Retorna y asigna la Fecha del Proceso
        /// </summary>
        public string FechaProceso
        {
            get { return _fechaProceso; }
            set { _fechaProceso = value; }
        }

        /// <summary>
        /// Retorna y asigna el Concepto
        /// </summary>
        public int Concepto
        {
            get { return _concepto; }
            set { _concepto = value; }
        }

        /// <summary>
        /// Retorna y asigna el CAE
        /// </summary>
        public string CAE
        {
            get { return _cae; }
            set { _cae = value; }
        }

        /// <summary>
        /// Retorna y asigna la Fecha de Vto. del CAE
        /// </summary>
        public string FechaVtoCAE
        {
            get { return _fechaVtoCae; }
            set { _fechaVtoCae = value; }
        }

        /// <summary>
        /// Retorna y asigna la Fecha de Vto. de Pago
        /// </summary>
        public string FechaVtoPago
        {
            get { return _fechaVtoPago; }
            set { _fechaVtoPago  = value; }
        }


        /// <summary>
        /// Retorna la lista de comprobantes asociados 
        /// </summary>
        public List<CompAsociadoClass> ListaCompAsociados
        {
            get { return _listaCompAsociados; }
        }
        /// <summary>
        /// Retorna la lista de Errores AFIP
        /// </summary>
        public List<string> ListaErroresAFIP
        {
            get { return _erroresAFIP; }
        }

        /// <summary>
        /// Propiedad que retorna la lista de errores AFIP
        /// </summary>
        public string ErroresAFIP
        {
            get
            {
                string retorno = "";

                foreach (string s in _erroresAFIP)
                {
                    retorno += s + "\n";
                }

                return retorno;
            }
        }

        /// <summary>
        /// Retorna la lista de Eventos AFIP
        /// </summary>
        public List<string> ListaEventosAFIP
        {
            get { return _eventosAFIP; }
        }

        /// <summary>
        /// Propiedad que retorna la lista de eventos AFIP
        /// </summary>
        public string EventosAFIP
        {
            get
            {
                string retorno = "";

                foreach (string s in _eventosAFIP)
                {
                    retorno += s + "\n";
                }

                return retorno;
            }
        }

        /// <summary>
        /// Retorna la lista de Observaciones AFIP
        /// </summary>
        public List<string> ListaObservacionesAFIP
        {
            get { return _observacionesAFIP; }
        }

        /// <summary>
        /// Retorna y asigna la lista de Opcionales
        /// </summary>
        public List<OpcionalComprobanteClass> ListaOpcionales
        {
            get { return _listaOpciones; }
            set { _listaOpciones = value; }
        }

        /// <summary>
        /// Propiedad que retorna la lista de observaciones AFIP
        /// </summary>
        public string ObservacionesAFIP
        {
            get
            {
                string retorno = "";

                foreach (string s in _observacionesAFIP)
                {
                    retorno += s + "\n";
                }

                return retorno;
            }
        


        }

        
       
        /// <summary>
        /// Retorna y asigna la condicion de iva del receptor
        /// </summary>
        public int CondicionIVAReceptorId
        {
            get { return _condicionIVAReceptorId; }
            set { _condicionIVAReceptorId = value; }
        }

        /// <summary>
        /// Retorna y asigna si el comprobante se cancela en la misma moneda del comprobante (moneda extranjera)
        /// </summary>
        public string CanMisMonExt
        {
            get { return _canMisMonExt; }
            set { _canMisMonExt = value; }
        }


        #endregion

        #region Constructor
        /// <summary>
        /// Constructor por defecto de la clase ComprobanteClass
        /// </summary>
        public ComprobanteClass()
        {

            _ptoVta = 0;
            _tipoComprobante = 0;
            _docTipoEmpresa = 0;
            _nroDocEmpresa = "";
            _docTipoCliente = 0;
            _nroDocCliente = "";
            _nroComprobante = 0;
            _fechaComprobante = "";
            _importeTotal = 0.0f;
            _importeNeto = 0.0f;
            _importeOpEx = 0.0f;
            _importeTotConc = 0.0F;
            _importeTrib = 0.0f;
            _importeIva = 0.0f;
            _idMoneda = "";
            _cotizacionMoneda = 0.0f;
            _listaIva = new List<AlicuotaIvaClass>();
            _listaTributos = new List<TributoComprobanteClass>();
            _resultado = "";
            _reproceso = "";
            _fechaProceso = "";
            _concepto = 0;
            _cae = "";
            _fechaVtoCae = "";
            _fechaVtoPago = "";
            _listaCompAsociados = new List<CompAsociadoClass>();
            _erroresAFIP = new List<string>();
            _eventosAFIP = new List<string>();
            _observacionesAFIP = new List<string>();
            _listaOpciones = new List<OpcionalComprobanteClass>();
            _condicionIVAReceptorId = 0;
            _canMisMonExt = "";
        }

        #endregion

        #region Metodos

        /// <summary>
        /// Agregar alicuota Iva a la lista del comprobante
        /// </summary>
        /// <param name="alicIva">Alicuota Iva a agregar al comprobante</param>
        public void addAlicuotaIva(AlicuotaIvaClass alicIva)
        {
            ListaIva.Add(alicIva);
        }

        /// <summary>
        /// Agrega la Alicuota de iva a la lista, si ya se encuentra una alicuota con el mismo ID suma Imoorte y base imponible
        /// </summary>
        /// <param name="alicuota"></param>
        public void agruparAlicuotaIva(AlicuotaIvaClass alicuota)
        {

            int idAlic = alicuota.ID;
            Double baseImp = alicuota.BaseImp;
            Double importe = alicuota.Importe;

            if (ListaIva.Count() > 0)
            {
                int indiceAlicuota = ListaIva.FindIndex(a => a.ID == idAlic);

                if (indiceAlicuota >= 0)
                {
                    ListaIva.ElementAt(indiceAlicuota).Importe += importe;
                    ListaIva.ElementAt(indiceAlicuota).BaseImp += baseImp;
                }
                else
                {
                    ListaIva.Add(alicuota);
                }


            }
            else
            {
                ListaIva.Add(alicuota);
            }


        }
        /// <summary>
        /// Quita alicuota Iva de la lista del comprobante
        /// </summary>
        /// <param name="alicIva">Alicuota Iva a quitar del comprobante</param>
        /// <returns>Retorna True si se quitó correctamente, False en otro caso</returns>
        public bool quitarAlicuotaIva(AlicuotaIvaClass alicIva)
        {
            bool r = false;
            r = ListaIva.Remove(alicIva);

            return r;
        }

        /// <summary>
        /// Agrega el tributo a la lista de tributos del comprobante
        /// </summary>
        /// <param name="tributo">Tributo a agregar al comprobante</param>
        public void addTributo(TributoComprobanteClass tributo)
        {
            ListaTributos.Add(tributo);
        }



        /// <summary>
        /// Agrega el Opcional a la lista de opcionales
        /// </summary>
        /// <param name="opcional">Opcion a agregar al comprobante</param>
        public void addOpcional(OpcionalComprobanteClass opcional)
        {
            ListaOpcionales.Add(opcional);
        }

        /// <summary>
        /// Carga las opciones pasadas como parámetros al comprobante. Convirtiendola a una entidad del objeto OpcionalComrpobanteClass
        /// </summary>
        /// <param name="listaOpcionales">Lista de opcionales con el siguiente formato: [id,valor;id,valor] </param>
       
        public void cargarOpcionales(string listaOpcionales)
        {
            

            List<OpcionalComprobanteClass> opciones = OpcionalComprobanteClass.ObtenerOpcionalesDesdestring(listaOpcionales);
     
            _listaOpciones.AddRange(opciones);
               
         }

        /// <summary>
        /// Agrega el tributo a la lista, si ya se encuentra un tributo con el mismo ID suma el importe y la base imponible
        /// </summary>
        /// <param name="tributo"></param>
        public void agruparTributo(TributoComprobanteClass tributo)
        {

            int idTributo = tributo.ID;
            Double baseImp = tributo.BaseImponible;
            Double importe = tributo.Importe;

            if (ListaTributos.Count() > 0)
            {
                int indiceTributo = ListaTributos.FindIndex(t => t.ID == idTributo);

                if (indiceTributo >= 0)
                {
                    ListaTributos.ElementAt(indiceTributo).Importe += importe;
                    ListaTributos.ElementAt(indiceTributo).BaseImponible += baseImp;
                }
                else
                {
                    ListaTributos.Add(tributo);
                }


            }
            else
            {
                ListaTributos.Add(tributo);
            }


        }


        /// <summary>
        /// Quita el tributo pasado como parámetro de la lista de tributos del comprobante
        /// </summary>
        /// <param name="tributo">Tributo a quitar de la lista de comprobantes</param>
        /// <returns>True si se quitó correctamente, False en otro caso</returns>
        public bool quitarTributo(TributoComprobanteClass tributo)
        {
            bool r = false;
            r = ListaTributos.Remove(tributo);

            return r;
        }


        public bool cargarRespuesta(ClienteLoginCms_CS.ar.gov.afip.wswhomo.FECAEResponse respuestaAfip)
        {
            bool retorno = false;

            if (respuestaAfip != null)
            {

                
                ClienteLoginCms_CS.ar.gov.afip.wswhomo.FECAECabResponse cabecera = respuestaAfip.FeCabResp;
                ClienteLoginCms_CS.ar.gov.afip.wswhomo.FECAEDetResponse detalle = respuestaAfip.FeDetResp.First(); //Siempre hay un comprobante en el detalle


                // Cargo Lista de errores si es que tiene
                _erroresAFIP = new List<string>();
                if (respuestaAfip.Errors != null)
                {
                    foreach (ClienteLoginCms_CS.ar.gov.afip.wswhomo.Err e in respuestaAfip.Errors)
                    {
                        string error = e.Code.ToString() + ";" + e.Msg;
                        _erroresAFIP.Add(error);
                    }
                }

                // Cargo Lista de eventos si es que tiene
                _eventosAFIP = new List<string>();
                if (respuestaAfip.Events != null)
                {
                    foreach (ClienteLoginCms_CS.ar.gov.afip.wswhomo.Evt e in respuestaAfip.Events)
                    {
                        string evento = e.Code.ToString() + ";" + e.Msg;
                        _eventosAFIP.Add(evento);
                    }
                }


                // Cargo Lista de observaciones si es que tiene
                _observacionesAFIP = new List<string>();
                if (detalle.Observaciones != null)
                {
                    foreach (ClienteLoginCms_CS.ar.gov.afip.wswhomo.Obs e in detalle.Observaciones)
                    {
                        string observacion = e.Code.ToString() + ";" + e.Msg;
                        _observacionesAFIP.Add(observacion);
                    }
                }

                if (cabecera.Resultado != "R") //Aprobado o Parcial
                {
                    if (detalle.Resultado == "A") // Aprobado
                    {
                        _resultado = detalle.Resultado;
                        _cae = detalle.CAE;
                        _fechaVtoCae = detalle.CAEFchVto;
                        _nroComprobante = detalle.CbteDesde;

                    }
                    else //Rechazado
                    {
                        _resultado = detalle.Resultado;
                        _cae = "";
                        _fechaVtoCae = "";

                    }

                }
                else //Rechazado
                {
                    _resultado = cabecera.Resultado;
                    _cae = "";
                    _fechaVtoCae = "";
                }

            }

            retorno = true;
            return retorno;
        }

        public bool cargarRespuesta(ClienteLoginCms_CS.ar.gov.afip.servicios1.FECAEResponse respuestaAfip)
        {
            bool retorno = false;

            if (respuestaAfip != null)
            {
                ClienteLoginCms_CS.ar.gov.afip.servicios1.FECAECabResponse cabecera = respuestaAfip.FeCabResp;
                ClienteLoginCms_CS.ar.gov.afip.servicios1.FECAEDetResponse detalle = respuestaAfip.FeDetResp.First(); //Siempre hay un comprobante en el detalle


                // Cargo Lista de errores si es que tiene
                _erroresAFIP = new List<string>();
                if (respuestaAfip.Errors != null)
                {
                    foreach (ClienteLoginCms_CS.ar.gov.afip.servicios1.Err e in respuestaAfip.Errors)
                    {
                        string error = e.Code.ToString() + ";" + e.Msg;
                        _erroresAFIP.Add(error);
                    }
                }

                // Cargo Lista de eventos si es que tiene
                _eventosAFIP = new List<string>();
                if (respuestaAfip.Events != null)
                {
                    foreach (ClienteLoginCms_CS.ar.gov.afip.servicios1.Evt e in respuestaAfip.Events)
                    {
                        string evento = e.Code.ToString() + ";" + e.Msg;
                        _eventosAFIP.Add(evento);
                    }
                }


                // Cargo Lista de observaciones si es que tiene
                _observacionesAFIP = new List<string>();
                if (detalle.Observaciones != null)
                {
                    foreach (ClienteLoginCms_CS.ar.gov.afip.servicios1.Obs e in detalle.Observaciones)
                    {
                        string observacion = e.Code.ToString() + ";" + e.Msg;
                        _observacionesAFIP.Add(observacion);
                    }
                }

                if (cabecera.Resultado != "R") //Aprobado o Parcial
                {
                    if (detalle.Resultado == "A") // Aprobado
                    {
                        _resultado = detalle.Resultado;
                        _cae = detalle.CAE;
                        _fechaVtoCae = detalle.CAEFchVto;
                        _nroComprobante = detalle.CbteDesde;

                    }
                    else //Rechazado
                    {
                        _resultado = detalle.Resultado;
                        _cae = "";
                        _fechaVtoCae = "";

                    }

                }
                else //Rechazado
                {
                    _resultado = cabecera.Resultado;
                    _cae = "";
                    _fechaVtoCae = "";
                }

            }

            retorno = true;
            return retorno;
        }

        public List<string> CargarCompAsociados(string ubicacionAso,string cuitEmisor)
        {

            List<string> retorno = new List<string>();

            try
            {
                if (ubicacionAso == null || ubicacionAso.Length == 0) // Nombre del Archivo de configuración incorrecto
                {
                  
                   retorno.Add("El nombre del Archivo de configuración es incorrecto");
                    retorno = null;
                }
                else
                {

                 


                    XmlDocument compXML = new XmlDocument();

                    compXML.Load(ubicacionAso);



                    // Cargo la lista de nodos del XML, cada nodo de la lista es un registro en la tabla de facturas de donde proviene el archivo xml
                    XmlNodeList listaNodosXml = compXML.SelectNodes("//tablaasofac");
                    int cantNodos = listaNodosXml.Count;


                    //Cargo los datos del comprobanteAsociado desde el archivo XML
                    for (int i = 0; i < cantNodos; i++)
                    {
                       
                        CompAsociadoClass compAsociado = new CompAsociadoClass();

                        XmlNode nodo = listaNodosXml.Item(i);


                        compAsociado.IDComprobante = Int32.Parse(nodo.SelectSingleNode("idfactura").InnerText);
                        compAsociado.PtoVta = Int32.Parse(nodo.SelectSingleNode("puntov").InnerText);
                        compAsociado.NroComprobante = Int32.Parse(nodo.SelectSingleNode("numero").InnerText);
                        compAsociado.TipoComprobante = Int32.Parse(nodo.SelectSingleNode("codafip").InnerText);
                        compAsociado.FechaComprobante = nodo.SelectSingleNode("fecha").InnerText;
                        compAsociado.Cuit = nodo.SelectSingleNode("cuit").InnerText;
                        compAsociado.CuitEmisor = cuitEmisor;


                        _listaCompAsociados.Add(compAsociado);
                    }

                }
            }
            catch (Exception e)
            {

                string mensaje = "Ocurrio un error: " + e.Message;
                throw new Exception(mensaje);
            }
            return retorno;

        }
        #endregion

    }
}
