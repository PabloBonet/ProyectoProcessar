using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace EntidadesClass
{
    public class OpcionalComprobanteClass
    {
        #region Propiedades
        private string _id;
        private string _valor;
        


        /// <summary>
        /// Retorna y asigna el Id del Opcional
        /// </summary>
        public string IDOpcional
        {
            get { return _id; }
            set { _id= value; }
        }

        /// <summary>
        /// Retorna y asigna el valor del Opcional
        /// </summary>
        public string Valor
        {
            get { return _valor; }

            set { _valor = value; }
        }

       
        #endregion

        #region Constructor
        /// <summary>
        /// Constructor por defecto de la clase OpcionalComprobanteClass
        /// </summary>
        public OpcionalComprobanteClass()
        {
            _id="0";
            _valor = "";
        }

        /// <summary>
        /// Constructor de la clase OpcionalComprobanteClass con valores
        /// </summary>
        /// <param name="id"></param>
        /// <param name="valor"></param>
        public OpcionalComprobanteClass(string id, string valor)
        {
            if ((id.Trim()).Length > 0)
            {
                _id = id;
            }
            else
            {
                _id = "0";

            }

            if (valor.Trim().Length > 0)
            {
                _valor = valor;
            }
            else
            {
                _valor = "";
            }
        }
        #endregion

        #region Métodos

        /// <summary>
        /// Convierte un string con las opciones con en una lista 
        /// </summary>
        /// <param name="listaOpcionales">Lista de opcionales con el siguiente formato: [id,valor;id,valor] </param>
        /// <returns>Retorna la lista con las opciones o la lista vacia en caso de error </returns>
        public static List<OpcionalComprobanteClass> ObtenerOpcionalesDesdestring(string listaOpcionales)
        {
            List<OpcionalComprobanteClass> listaRetorno = new List<OpcionalComprobanteClass>();

            try
            {                              
                string[] arregloOpcionales = listaOpcionales.Split(';');

                int cantElementos = arregloOpcionales.Length;

                for (int i = 0; i < cantElementos; i++ )
                {
                    string opcional = arregloOpcionales[i];

                    if(opcional.Length > 0)
                    {
                      
                        string[] idValor = opcional.Split(',');

                        if (idValor.Length > 0)
                        {
                            string id = idValor[0];
                            string valor = idValor[1];
                          
                            OpcionalComprobanteClass op = new OpcionalComprobanteClass(id, valor);
                            listaRetorno.Add(op);
                        }

                    }

                }

            }
            catch(Exception e)
            { 
                List<OpcionalComprobanteClass> listaRet = new List<OpcionalComprobanteClass>();
                return listaRet;
            }
           
            return listaRetorno;
        }
        #endregion

    }
}
