package com.cloud.storage.template;

import com.cloud.exception.InternalErrorException;
import com.cloud.storage.Storage.ImageFormat;
import com.cloud.storage.StorageLayer;
import com.cloud.utils.NumbersUtil;
import com.cloud.utils.component.AdapterBase;

import javax.naming.ConfigurationException;
import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.util.Map;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

public class QCOW2Processor extends AdapterBase implements Processor {
    private static final Logger s_logger = LoggerFactory.getLogger(QCOW2Processor.class);
    private static final int VIRTUALSIZE_HEADER_LOCATION = 24;

    private StorageLayer _storage;

    @Override
    public FormatInfo process(final String templatePath, final ImageFormat format, final String templateName) throws InternalErrorException {
        if (format != null) {
            s_logger.debug("We currently don't handle conversion from " + format + " to QCOW2.");
            return null;
        }

        final String qcow2Path = templatePath + File.separator + templateName + "." + ImageFormat.QCOW2.getFileExtension();

        if (!_storage.exists(qcow2Path)) {
            s_logger.debug("Unable to find the qcow2 file: " + qcow2Path);
            return null;
        }

        final FormatInfo info = new FormatInfo();
        info.format = ImageFormat.QCOW2;
        info.filename = templateName + "." + ImageFormat.QCOW2.getFileExtension();

        final File qcow2File = _storage.getFile(qcow2Path);

        info.size = _storage.getSize(qcow2Path);

        try {
            info.virtualSize = getTemplateVirtualSize(qcow2File);
        } catch (final IOException e) {
            s_logger.error("Unable to get virtual size from " + qcow2File.getName());
            throw new InternalErrorException("unable to get virtual size from qcow2 file");
        }

        return info;
    }

    @Override
    public long getVirtualSize(final File file) throws IOException {
        try {
            final long size = getTemplateVirtualSize(file);
            return size;
        } catch (final Exception e) {
            s_logger.info("[ignored]" + "failed to get template virtual size for QCOW2: " + e.getLocalizedMessage());
        }
        return file.length();
    }

    protected long getTemplateVirtualSize(final File file) throws IOException {
        final byte[] b = new byte[8];
        try (FileInputStream strm = new FileInputStream(file)) {
            if (strm.skip(VIRTUALSIZE_HEADER_LOCATION) != VIRTUALSIZE_HEADER_LOCATION) {
                throw new IOException("Unable to skip to the virtual size header");
            }
            if (strm.read(b) != 8) {
                throw new IOException("Unable to properly read the size");
            }
        }

        return NumbersUtil.bytesToLong(b);
    }

    @Override
    public boolean configure(final String name, final Map<String, Object> params) throws ConfigurationException {
        _storage = (StorageLayer) params.get(StorageLayer.InstanceConfigKey);
        if (_storage == null) {
            throw new ConfigurationException("Unable to get storage implementation");
        }

        return true;
    }
}
