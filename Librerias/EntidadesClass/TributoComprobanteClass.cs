﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace EntidadesClass
{
    public class TributoComprobanteClass
    {

        #region Atributos

        private int _id;
        private string _descripcion;
        private Double _baseImponible;
        private Double _alicuota;
        private Double _importe;

        /// <summary>
        /// Asigna y retorna el ID del Tributo
        /// </summary>
        public int ID
        {
            get { return _id; }
            set { _id = value; }
        }

        /// <summary>
        /// Asiga y retorna la descripción del Tributo
        /// </summary>
        public string Descripcion
        {
            get { return _descripcion; }
            set { _descripcion = value; }
        }

        /// <summary>
        /// Asigna y retorna la Base imponible del Tributo
        /// </summary>
        public Double BaseImponible
        {
            get { return _baseImponible; }
            set { _baseImponible = value; }
        }

        /// <summary>
        /// Asigna y Retorna la Alicuota del Tributo
        /// </summary>
        public Double Alicuota
        {
            get { return _alicuota; }
            set { _alicuota = value; }
        }

        /// <summary>
        /// Asigna y retorna el Importe del Tributo
        /// </summary>
        public Double Importe
        {
            get { return _importe; }
            set { _importe = value; }
        }

        #endregion

        #region Constructor


        /// <summary>
        /// Constructor de la clase TributoComprobanteClass
        /// </summary>
        public TributoComprobanteClass()
        {
            _id = 0;
            _alicuota = 0;
            _baseImponible = 0;
            _descripcion = "";
            _importe = 0;
        }



        #endregion
    }
 }
