using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace EntidadesClass
{
    public class AlicuotaIvaClass
    {
        #region Atributos
        private int _id;
        private Double _baseImp;
        private Double _importe;
        private string _detaAfip;
        private string _tipoAfip;

        /// <summary>
        /// Asigna y retorna el ID
        /// </summary>
        public int ID
        {
            get { return _id; }
            set { _id = value; }
        }

        /// <summary>
        /// Asigna y retorna la Base imp.
        /// </summary>
        public Double BaseImp
        {
            get { return _baseImp; }
            set { _baseImp = value; }
        }

        /// <summary>
        /// Asigna y retorna el Importe
        /// </summary>
        public Double Importe
        {
            get { return _importe; }
            set { _importe = value; }
        }

        /// <summary>
        /// Asigna y retorna el Detalle del tipo de impuesto afip
        /// </summary>
        public string DetaAfip
        {
            get { return _detaAfip; }
            set { _detaAfip = value; }
        }


        /// <summary>
        /// Asigna y retorna el tipo de impuesto
        /// </summary>
        public string TipoAfip
        {
            get { return _tipoAfip; }
            set { _tipoAfip = value; }
        }

        #endregion


        #region Constructor
        /// <summary>
        /// Constructor por defecto de la clase AlicuotaIvaClass
        /// </summary>
        public AlicuotaIvaClass()
        {

            _id = 0;
            _baseImp = 0.0f;
            _importe = 0.0f;
            _detaAfip = "";
            _tipoAfip = "";

        }
        #endregion



        #region Metodos

        #endregion
    }
}
