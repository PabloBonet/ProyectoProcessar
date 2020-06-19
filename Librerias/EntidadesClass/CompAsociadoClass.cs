using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace EntidadesClass
{
    public class CompAsociadoClass
    {
        #region Propiedades
        private int _idComprobante;
        private int _ptoVta;
        private int _tipoComprobante;
        private long _nroComprobante;
        private string _cuitEmisor;
        private string _fechaComprobante;


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
        /// Retorna y asigna el Número del cuit de la empresa emisora
        /// </summary>
        public string CuitEmisor
        {
            get { return _cuitEmisor; }
            set { _cuitEmisor = value; }
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
        #endregion

        #region Constructor
        /// <summary>
        /// Constructor por defecto de la clase CompAsociadoClass
        /// </summary>
        public CompAsociadoClass()
        {
            _idComprobante = 0;
            _ptoVta = 0;
            _tipoComprobante = 0;
            _nroComprobante = 0;
            _cuitEmisor = "";
            _fechaComprobante = "";
    }
        #endregion

        #region Metodos
        #endregion
    }
}
