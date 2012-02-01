require "zlib"

require "yard-sd/sequence_diagram/parse_error"
require "yard-sd/sequence_diagram/participant"
require "yard-sd/sequence_diagram/diagram"

module SequenceDiagram
  # Author: Xu Yuan <xuyuan.cn@gmail.com>, Southeast University, China
  # Contributor: Nobel Huang <nobel1984@gmail.com>, Southeast University, China
  Template = Zlib::Inflate.inflate "x\x9C\xE5ZK\x8F\xDB8\x12\xBE\xF7\xAF\xE0\xA2\xD1@w\xDA\x16\xFC\xE8\xCE\x06\t\x9C\xC3\xCC\x06\x8B=\f\xB0X\xCC\xCD6\x06\xB4D\xDB\x9C\x96H\rE\xB5\xE3\xD1\xEA\xBFo\x15\x1F\x12\xF5pO\xD2\xC9a13\x87\x8EE\x16\x8B\xF5\xFCX,\xCE&\x91q\x991\xA1\xE3\x94\x16EUh*\x12\x9AJ\xC1\xEA\xABMN\x0F\xAC\xD0\xE7\x94U,\xCB\xF5\x19F\xCA\x82\xE54~\x82\xF1J\xF3\xA7\xDF\xEB+3\x84?S\xBEST\x9D+\xAA\x94<\x150qC\x12\x06<\x15#)=3U\x00\xBB\xC3\xDE\r\x99\x91j\a\x9C\x0EJ\x96\"\xA9\x87\x93\xFA\xA8\x18M\xC2i\xD8\xC7r\n\x16NB\xB2IF\xB90;\vv\"1\fi\xB3/|\xB9\x8F*W\x8C\x8BB\xD7\x9DA\x1C\x11e\xD6\x1D\xB4\x8C\a\xC3\x05\xFB-e\xCF,\xAD\xC9\r1?:\xB31M\xED\xEC`\xB4`\xE9~dj\x97\xCA\xF8\xC9\x8D;\xB9\xA9 (\x10\x151\x83\x91O\x9Fi\x96\xA7\xEC=\xFC\xC4u8\xB3f\xC9\x81\x91\x84[\x9Am\xF5LU]\t\x9A\xB1\xF7\xC6\x85~\x83,\x03OV~Q\xBD^n\xD7\xB3h\xB1\xAD\xAE\b\xD9\x14\x9A\xE5\x03\xEDa<\xA7\xFAHnqd\xA3\x8F\xCC\x19+b\xB4\xD0w\xF7\xB7\xD7\xF3\xC9\xEC\x8E\b\x99\xB05\x0E\x9B\xC0\xD8\xB6\xD4\x8E\xCF\x1D\xF0\xA96\xE0\r\xA6R.Xu\xBD\xAC\xEB\x0FC\xDE\x9E\xFA\xFEv6\x99\xCE\xA2\xC77\xB0\x84\xEB=\x8D\xB5Tv\x13r{\xBD\xB8#\x95]\x8C\x11f#\x11\x17\xC62\x95\xEAzQ\xAF\xD6\xDB\xBE6\x8D\x83\xC7\xECI\xACS/\x98\xD5p\r\xCCYW\x17\xECi\xB9\x18\x8B\x1E\x14=\xFFm9\xB3Vu\x8C*\x90\f\xD5\xEE\x8B\x16D\x14\x12\xA3\x1Dw,\x95'\"\xF7\xAB\x9EY&\xC6\x00\xDE\xC5\xABY\xF4.\xCE\xC0\xD4\x96\x03\xD25\xBCF,d\xE7\x8C6\x1DR0\xD7\x9E\xA7\xE9\xEAz\xBE}\xC9\xA4\r\x8D\xCDaEOD\x95Bpq@\x01x\xFCtG\xD0\xB1\x13R\x1Ce\x99&\xE0+M0\xC2A\\\xC5b\x9D\x9EC{\xBD\xA96\xC8\xC1[\xCC\x85\xDF\x8E\x1D\xB8\xA8 \xA5\xA50\x19]\xF7\xB2\x9D\xC0\x7Ff\xDD\xDA\x8E\e1';\xA9 \xA8~\xB1\x1FF\xCA\xD3\x91k\f\xC1\xEByt\x02\xA0\xBA#\xD3\xA9\xF90\x01k?\x16\xDD\x8F\x86,>\xC7)3\x86c\xE0\xD5@\x14\xAB6%\xFBR\xC4\x9AKat\xEBE\x8C\x95\x1F'\xEA5\xF8\xECp\xD4[\x9B\xFA\xA0\x89_W\xDB\x11\x88\"\xC5t\xA9\x00\x97n\xEC^f\x99\xB1\x11\x13\xCF\\I\x81\xE0\xEB\x98=n\xD7\xF3a\x866\x98\xD3\x9Fh\xE0\x06\xC0(/\x8B\xA3O3\xF8\x17\x93\xC7\xE4\x16\x86\x80g\x10&\x19$\xDD\xDF\xC7\x92.\xDE\xE3\n\xCF\x19\xC3\xCBp{\x886\xD6\x17;N\x8BWr\xD6}\xCE\x1F\xAE\xAE\xBC\xA3\xCD\xB1\xE1|;\xFD8\xF9\xB8\xD2\x8ASqH\x19y;\x03\x0FW]\xB1j\xEB\xD0\x1EG`f\xB2*\xE3\xC9\x89\x9E'\x84\xEE\xE43\x84\a\xE6\xA2\xF1t\xC2\xF6\x9B4\\Q]\xCFk?\xB1\xEFN,\x9A\t\xDD\x9Dxh&\xAC_\x9FiZ\x02\xCA=\xD6cIh~\xD7\xF7\xABu\x90b\x98X\xC6\xC54I\xB4\x1C\xF8\xB8\xEA\x8AX\x87>\xED\n\xF9:/\xA8Q\xFFv\xB5\xFCv_\xAB\x11_\x8F\xB9:\xA1\xC5\x91%\xD6\xE3\xA1\xBB\xBB\xEB\x9D\xBB{\xA2\x8F\xBB\xBB\n\xFD\xD2\xEEj\x15\xAA\xBA\x11S\xF7\xF7\x19\xB8\xA5\xA5\x9C\xCEM\x96\xC9|\x00\x10\x894\x18(\x18K,\x10J`\tu\xC7%\xCC\xC0R\xE0%\xDC\x18\xC1\v\xB3d\x143,\xB3\x87o\xC7\x8D\xFE|P\xB0\f`\xC5\xDB\xAC\xA1y3\x8B\xE6\x10\n\xF3\xAF\x0F\x94\"\x1E\v\xC7\xAA;\\\xFB\x12\xC4\xD4\n\xCB\xE58\xA3\xDD\v\xF0\x82'\x96\xC9\xBF\x89f\x9F\xF5j\x97B\x059\x8A3\xA3\ec\xF4\xDD\xC3\xEE\xD1;\xA8\x80|\xD8\tF\x15\x81\x03Zi\x17zD\x19\x8F\x1A\xBC\xF1+F\xE4\x85\xF5\x18\xCC}y\xBF\x01\xA1:@\xF4\xF05@\xF4\n\x1C\x1AA\xA1\xD7\x85\xC3\x98\e\xD1\xF7\xC5\x8B\xE7\x04\xFEY\xB5\xDE\xBC\x84\x1F=&\xDE\x8F\xED\x1E\xAC\xBFG\xC7\xC7\xF8\xD1\xC1\x16\xEB\xDA.\xB6\\r\xB0\xE34\xB5\xAC\xFA\b\xD4\xF3{]\xF5d\xF92\f\x1A\xA3i3\x16\t-Le\xAC(\xE0\xB2FvL\x9F\x18\x13\xAE\x00\xEEc\x13R\x81\xE7\xB1f\xAF+\xBF$\x96\xC0Yh\xC4\xA3\x98\xF1g,\x8D:\x850\xD2a\r\xFC2\xEC4\xB81\x7F\xDDA\x82\xBB\x00t6u\xC8\xF2\xF5l@\xBF\xEEA\xD4\x8F\x9Af/\xCC\xCFf\xC5xI\xB1\x00>x\xFB\xEDA2\xAE\xB2\xA5\xDCw\x80\xE4?K)\xF7\x7F\\\xC7\xFD\x15\v\xB6\xD1\xE3\xF3\x85\x82\xED{\x97N\xFFB\x18b\xA4\xE0\xBA\xA4\xA6\x80\x92{\x92\x95\xA9\xE6S\xE7\x03\xB8Z\xCA\x8C\x11\xB9\xFB\x15\xEE\x93\x05\xC1\x16\x92a\x96\x10\xAAq)\xF0(\xE0~N4\xCFXD~,\x95\x82\xD4K!PN\x8C\x1C)\x1C\xC4Z\x12\x9A\xFCZ\x16\x86\x9A\xA0Qp\x0F\xCB\xDD\\^\x11\x19\xA9(\x81\xE99\"\xFF\x96E\xC1w\x10\xA19U\xC0\x16{F\xB8\xE7{\x123T\x04\xD9\x16p\xC6\xE3\t\xD2E\xC0\x82\xE9\xD6\xEC5\xA6\xFB\xE6\x90\xCA\x1DMm\xBC5S\x18\x9E_\xA59\x98M\x80\xE2G\x9A\xE7\x80\xD9Vi\xA32\xF0\xF8B\xA5\x8D\xE9o\x91\xF8\x0Ew\xB1\x1C;j\xFF|\xE4E[\xC4f\xF4\x89\x15f\xA5)a\xA1\xB6I9SQW\xE1\\1\x1F\xF3\x17ra\xEA4\xA5\xC4t\xB6\xC8N~&'\x0EUCLs\xDC\xA7\xAD\x84\x8B\xC4P\xD4k7C\xDA\xA6\x1Eq\x9D\x187\x037i\x10\x00\xE5ojb\xBFx\x80\xBF\r\xD7\xE5vm\xBB\x03_\x0E\xC1A/.\x00\xE1XJ\x95pA5$\x89\xA1\x00\xF11\xF0[\xEA;\xF4\xD0\x8B9\x17\xE6\xDB\x87\x17\xE5\xC1\xC01\x9C\x9B\xF6M\xBBO\x88rf\x14\x9BT}\x92E\x9FM\x96\xF5Ilg\xAA\xE9\xC1p\x94B\x95\xB9\xDE\xA1\xED\xB98\x80\xCFjW\x1A\x0E\x947'\xE2\x1F\xA9\xBBx3P\xD8V\x8E\xB1\x8DZ\xE2w\xC2\xF0hJ\xFBh\xE1\xDB\x8B\xB0\x97\xFCl\v6\vv\xA3\xEB0+\xC9\x7F\xA7\xA4\x1A\xF7\n\x1C-\xF7\x04\x8B\xB0E[\xB3\x93[qj\xA0\xCD\x8A\xE4vBF\xAD\x82\xEEF\xC1:0h\x17c\x8B\xCB\x9Eg8oN=\xCCI\x9D\xB2\xB6\xA9\x87||w\xD4|\x98yk7#\xC0%\xF7u\x04k\x16F\x85,a\xC4\x1A\xE4\x1EM\x0FJ\xB5B6V\xBA\xBCb\xDA1n\xC1v#K\x84T\x9DM\xC2\x15\x18E\xDD\xD2\xC9\xB4\xDF.F\xEAv\x84s\xDB\xA0\xBB\xB0\xE9tj*s\xA6#\x8B\xBB\x96\x18\x84\xED|\x0F\x94\x1C\xE9\xE8}\x17/\xB4L<\xFA\x84\xBC\xDC\x98\xE5\xE6\xCCs)\xE3\\m\xE4\xFA\x8C\xE3\xE9f\xC2\b0\x95\xE8\x93\x84\x93\x92#\xFC\x03\xA0?1\x96\xDB3,\x88\xFCF\xBAD\xC2m\xF3v\x8F\xCA4J\x05\xC2\xBB\xE9\xC2\xE9\xEC\xC3ypP\a\x92vo\x18\xE3(e\xF0\x1De\np\x17\x8F\x18\xA0(\x196\xD9\x13N\x0Fp\x90\x0E\xB1\xD9\x11\xB8\xF9:h\x05c\x19\x96\xF3\x18\xEEV\xCCu\x7F\xF1\xB1\x87\x89\x83>V\x06K\xEC\xEF\xBA\x9A\xC7\x99o\x0F\xB3\xBD\xBF\x05V\xBB\x83\xF9\xB7\xAE\xFE\xF3\xCF\x1F\xEAj\xB1|\x98\x90\xC5\xC3\f\xFE<>\x8EP7\xB7GG\xFF\xEEqB\xE6\xB3\x05\xFCY\xBEu\xE4mY\xE8\x85\xAEW\xEB\x16\f\xB7}\xAA\xB05\r\x94\xDDK\xEA\x80:(\x90\a\xC4\xB6\xB1}ym\xF3\xF2\x02+\e,\x9A\x90\x1E\x13BE|\x94je+\x97\x8C\v\x9E\x95\x19\xB1-'\xFB\x9A\xD0\x8E\x9Ex\xA2\x8F\xABy\xF4\x16\a\xCD\xEE\xCE\x9CC-\x9B\x94\x82\xCD\xDD\x0Emr\x8F\x93\x87\xC93\xB6\n\xB6\x84{\xE6jSdPv\fX@\b\xD7X\x8B\v\xA6 \xBE\xF2\xD5,\xD7\xD6@\xB6\x81\x13s\x059?\xF1\x9A\x14\xFCw|+Y\xE4^\x96\xA0\x1Ak\x0F\xA4j\x16y7\x8FWk\x16n,\xC9\r\x00>\x84b\xFB\x98\xE8\x83\xB3\xFF\xDET\xCD\xEA\xC1\x9C\x7FY\e\x9Bk_e\xC6f\xDB\x82jd\xB2-\xAC/L\x06\x8D\x80\x11\x8A0\xDDg\x06yPM\xA98$\xA2%6\xE8\x11D\xBB}\xB5\x9BY\xF8pw\xA1\xE1\x13N\xF8\x9Ak\xD8\xF0=\xA8\xB7\xB1m)o\n\xF2\x91\xCC\xEC\xEC^\x82\x01\xE2#x\x9B\xAC\x19\x12\xC1N\xAB\r \x16\x17\xA4\x9AO\xA2(\x9A\x04\x0Fb\x06,\xDAg\xA1a\v\xB9y\x88\xBCk[o\x97\v\x94hX\xA2\x10\xE2\xC4\xDE\xF3\xA1\xF8\xAD\xB7\xBEZ\x81\xC0\xD1^\x05{\xC0\xFB\xC7\xBC?\xBC\xAF\xCD\xC7\xEEkvu\xD0\xD2\xE8eN\xEF:\xDBy\x13\xDC\x86\xB6t\xB7;/\x8D\x7F\x8Ac\xDE\x8D\xA1U\x06oef \x04ol\x89\xD8\xD0\xF0\xFF[\x01\xD4\xEC7\x9F~\xFA\xE1\xD3?,q;\xFC?$\xF7\x89\xD2"

  def self.latex_escape(s)
    s.gsub(/\\|~|[#%&{}$_]/) do |m|
      case m
      when "\\"
        "\\textbackslash{}"
      when "~"
        "\\textasciitilde{}"
      else
        "\\#{m}"
      end
    end
  end
end
