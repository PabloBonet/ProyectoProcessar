using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace ModuloAFIP
{
    public class UtilClass
    {
        /// <summary>
        /// Escribe el mensaje pasado como parámetro en el archivo de log
        /// </summary>
        /// <param name="mensaje"> Mensaje a escribir en el log</param>
        /// <param name="archivoLog">ubicación del archivo de log</param>
        /// <param name="flujoEscritura">Flujo de escritura para el arhivo</param>
       // public static void EscribirArchivoLog(string mensaje, FileStream archivoLog, StreamWriter flujoEscritura, string strLog, bool conFecha = true)
        public static void EscribirArchivoLog(string mensaje,  string strLog, bool conFecha = true)
        {
            try
            {
                if(strLog.Length > 0)
                {
                    if (conFecha)
                    {
                        string strFechaHora = "";

                        DateTime fechaHora = DateTime.Now;

                        strFechaHora = fechaHora.ToString();

                        mensaje = "[" + strFechaHora + "] " + mensaje;
                    }

                    StreamWriter archivoLog = new StreamWriter(strLog, true);

                    archivoLog.Write(mensaje);

                    archivoLog.Close();

                }


            }
            catch (Exception e)
            {
                Exception exep = new Exception("Error al intentar escribir en el archivo de log\n" + e.Message);
                throw exep;

            }

             
             
        }

        /// <summary>
        /// Cambia el formato del CUIT a un formato sin guiones
        /// </summary>
        /// <param name="cuit">CUIT con guiones</param>
        /// <returns>Retorna CUIT sin guiones</returns>
        public static string CambiarFormatoCuitSinGuiones(string cuit)
        {
            string cuitSinGuiones = "";



            foreach (char c in cuit)
            {
                if (c != '-')
                {
                    cuitSinGuiones += c;
                }
            }


            return cuitSinGuiones;
        }
    }
}
