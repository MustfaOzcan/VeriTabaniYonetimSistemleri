using Npgsql;
using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;

namespace VTYS_PROJE1
{
    public partial class Form3 : Form
    {
        public Form3()
        {
            InitializeComponent();
        }
        //BAGLANTI
        NpgsqlConnection baglanti = new NpgsqlConnection("server=localHost;port=5432;Database=Proje1_Yedek;userID=postgres; password=123456");
        private void Form3_Load(object sender, EventArgs e)
        {
            //listeleme
            string sorgu4 = "SELECT * FROM tbl_silinenyemek order by kayit ";
            NpgsqlDataAdapter da4 = new NpgsqlDataAdapter(sorgu4, baglanti);
            DataSet ds4 = new DataSet();
            da4.Fill(ds4);
            dataGridView4.DataSource = ds4.Tables[0];

        }
    }
}
