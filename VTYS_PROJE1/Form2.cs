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
    public partial class Form2 : Form
    {
        public Form2()
        {
            InitializeComponent();
        }
        //baglanti
        NpgsqlConnection baglanti = new NpgsqlConnection("server=localHost;port=5432;Database=Proje1_Yedek;userID=postgres; password=123456");
        //listeleme
        private void btn_listele_Click(object sender, EventArgs e)
        {
            string sorgu = "SELECT * FROM tbl_Insan order by Insan_id ";
            NpgsqlDataAdapter da = new NpgsqlDataAdapter(sorgu, baglanti);
            DataSet ds = new DataSet();
            da.Fill(ds);
            dataGridView1.DataSource = ds.Tables[0];

        }

        private void Form2_Load(object sender, EventArgs e)
        {
            string sorgu = "SELECT * FROM tbl_Insan order by Insan_id ";
            NpgsqlDataAdapter da = new NpgsqlDataAdapter(sorgu, baglanti);
            DataSet ds = new DataSet();
            da.Fill(ds);
            dataGridView1.DataSource = ds.Tables[0];
        }
    }
}
